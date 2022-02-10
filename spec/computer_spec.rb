require './lib/computer.rb'
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
board.create_columns

describe Computer do

  describe "initialize" do
    it "exist" do
      computer=Computer.new(board)
      expect(computer).to be_an_instance_of(Computer)
    end

    it "has a board" do
      computer=Computer.new(board)
      expect(computer.board).to eq(board)
    end
  end
  describe "play at random" do
    it "generates a random letter to play" do
      computer=Computer.new(board)
      computer_input=computer.random_letter
      expect(computer.board.valid_columns.keys.include?(computer_input)).to be true

    end
  end
end
