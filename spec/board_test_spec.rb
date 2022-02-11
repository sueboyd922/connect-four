require './lib/board.rb'
require 'rspec'
require 'pry'

A = Column.new("A", 0)
B = Column.new("B", 1)
C = Column.new("C", 2)
D = Column.new("D", 3)
E = Column.new("E", 4)
F = Column.new("F", 5)
G = Column.new("G", 6)

columns=[A, B, C, D, E, F, G]

board = Board.new(columns)

# binding.pry
describe Board do

  describe "#initialize" do
    it "exist" do
      expect(board).to be_an_instance_of(Board)
    end

    it "has an array of columns" do
      expect(board.columns).to eq([A, B, C, D, E, F, G])
    end
    it "starts witha an empty board" do
      expect{board.print_board}.to output(
        <<~EXPECTED
        A B C D E F G\n. . . . . . . \n. . . . . . . \n. . . . . . . \n. . . . . . . \n. . . . . . . \n. . . . . . . 
        EXPECTED
      ).to_stdout

    end
  end
end
