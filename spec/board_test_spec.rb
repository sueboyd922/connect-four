require './lib/board.rb'
require 'rspec'
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

# binding.pry
describe Board do

  describe "#initialize" do
    it "exist" do
      expect(board).to be_an_instance_of(Board)
    end

    it "has an array of columns" do
      expect(board.columns).to eq([a, b, c, d, e, f, g])
    end

    it "starts witha an empty board" do
      expect{board.print_board}.to output(
        <<~EXPECTED
        A B C D E F G\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .
        EXPECTED
      ).to_stdout

    end
  end
end
