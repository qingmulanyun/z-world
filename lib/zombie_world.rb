require 'byebug'
require '../models/zombie'

class ZombieWorld
  attr_accessor :dimensions, :moves, :creatures, :score, :zombies, :moving_zombie, :zombies_positions

  INFO_TYPES = [
      INFO = 'INFO',
      DEBUG = 'DEBUG',
      FATAL = 'FATAL'
  ].freeze

  def initialize(dimensions, zombie_seed, creatures, moves)
    @dimensions = dimensions
    @zombies = [Zombie.new(zombie_seed)]
    @creatures = creatures
    @moves = moves
    @score = 0
    @moving_zombie = nil
    @zombies_positions = []
  end

  def start
    while zombies.size > 0
      init_moving_zombie
      zombie_move
      move_completed
    end
  end

  private

  def init_moving_zombie
    @moving_zombie = zombies.first
    helper_info(INFO, "A zombie is ready to move at (#{moving_zombie.x}, #{moving_zombie.y})")
  end

  def zombie_move
    moves.split('').map { |m|
      moving_zombie.move(m, dimensions)
      encounter_creature
    }
  end

  def encounter_creature
    return unless bite_creature?
    helper_info(INFO, "Encounter a creature at (#{moving_zombie.x}, #{moving_zombie.y})")
    infect_creature
    create_zombie
    @score += 1
  end

  def bite_creature?
    creatures.include?([moving_zombie.x, moving_zombie.y])
  end

  def infect_creature
    creatures - [moving_zombie.x, moving_zombie.y]
    helper_info(INFO, "Infecting!")
  end

  def create_zombie
    zombies.push(Zombie.new([moving_zombie.x, moving_zombie.y]))
    helper_info(INFO, "A new zombie created!")
  end

  def insert_final_position
    zombies_positions.push([moving_zombie.x, moving_zombie.y])
    helper_info(INFO, "A zombie complete at (#{moving_zombie.x}, #{moving_zombie.y})!")
  end

  def move_completed
    insert_final_position
    zombies.shift
  end

  def helper_info(type, message)
    puts "[#{type}]: #{message}"
  end
end