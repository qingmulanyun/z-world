require 'zombie_world'

describe ZombieWorld do
  let(:zombie_world) { described_class.new(4, 'DLUURR', [2,1], [[0,1], [1,2], [3,1]]) }

  describe "#start" do
    it 'set a game score for the player' do
      zombie_world.start
      expect(zombie_world.score).to eq(3)
      expect(zombie_world.zombies_positions).to eq([[3, 0], [2, 1], [1, 0], [0, 0]])
    end
  end
end