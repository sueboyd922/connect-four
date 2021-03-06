require 'rspec'
require './lib/player'
require 'pry'

a = Column.new("A", 0)
b = Column.new("B", 1)
c = Column.new("C", 2)
d = Column.new("D", 3)
e = Column.new("E", 4)
f = Column.new("F", 5)
g = Column.new("G", 6)
columns = [a, b, c, d, e, f, g]
board = Board.new(columns)

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

  describe '#drop' do
    it 'can add an X to the board' do
      player = Player.new(board)
      player.drop("A")
      expect(player.board.lines[0][0]).to eq("X ")
    end

    it 'can add a piece on top of another' do
      player = Player.new(board)
      player.drop("A")
      player.drop("A")
      expect(player.board.lines[2][0]).to eq("X ")
    end

    it "can't choose to play a full column" do
      board = Board.new(columns)
      player = Player.new(board)
      @input= "A"
      expect(player.validate(@input)).to be true
      6.times do
        player.drop("A")
      end
      expect(player.board.valid_columns["A"][0]).to eq(6)
      @input= "A"
      expect(player.validate(@input)).to be false
    end

    it "can't choose and invalid_column" do
      player=Player.new(board)
      @input="P"
      expect(player.valid).to be false
    end
  end
end
