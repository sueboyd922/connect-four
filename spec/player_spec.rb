require 'rspec'
require './lib/player'

A = Column.new("A", 0)
B = Column.new("B", 1)
C = Column.new("C", 2)
D = Column.new("D", 3)
E = Column.new("E", 4)
F = Column.new("F", 5)
G = Column.new("G", 6)
valid_columns = [A, B, C, D, E, F, G]
board = Board.new(valid_columns)

describe Player do
  describe 'initialize' do
    it 'exists' do
      player = Player.new(board)
      expect(player).to be_an_instance_of(Player)
    end

    it 'has a board to play on' do
      player = Player.new(board)
      expect(player.board).to eq(board)
    end
  end

  describe 'playing a turn' do
    it 'can\'t play a column that has 6 pieces in it' do
      player = Player.new(board)
      B = Column.new("B", 1, 6)
      require 'pry'; binding.pry
      expect(B.count).to eq(6)
      @input = "B"
      expect(player.validate).to eq("Column full, choose again")
    end
  end





end
