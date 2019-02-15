require_relative 'zombie_world'

class Client
  attr_accessor :inputs

  def initialize(input_path)
    @inputs = File.readlines(input_path).map(&:chomp)
  end

  def start
    z_world = ZombieWorld.new(
        inputs[0].to_i,
        inputs[1][1..-2].split(')(').first.split(',').map(&:to_i),
        inputs[2][1..-2].split(')(').map{|s| s.split(',').map(&:to_i)},
        inputs[3])
    z_world.start
    result_output(z_world)
  end

  private

  def result_output(z_world)
    puts "zombies score: #{z_world.score}"
    puts "zombies positions: #{z_world.zombies_positions.to_s}"
  end
end