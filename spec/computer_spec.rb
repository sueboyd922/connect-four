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

#test the computer class
describe Computer do

  describe "initialize" do
    #confirms there is a computer to play against
    it "exist" do
      computer=Computer.new(board)
      expect(computer).to be_an_instance_of(Computer)
    end

    #confirms there is is a board to play on
    it "has a board" do
      computer=Computer.new(board)
      expect(computer.board).to eq(board)
    end
  end

  describe "play at random" do
    #confirms the computer can randomly select a column to play in
    it "generates a random letter to play" do
      computer=Computer.new(board)
      computer_input=computer.random_letter
      expect(computer.board.valid_columns.keys.include?(computer_input)).to be true
    end
  end


  describe '#drop' do
    #confirms the computer can play an "O" after a valid column is selected
    it 'can add an O to the board' do
      computer = Computer.new(board)
      # binding.pry
      computer.drop("A")
      expect(computer.board.lines[0][0]).to eq("O ")
    end

    #confirms the computer will select a different column if the initial column is full
    xit "Only plays letter if column is not full" do
      #expect the computer to drop an "O" to column "C" if all other columns are full

      # computer.board.add_O(0, 1)
      # computer.board.add_O(1, 1)
      # computer.board.add_O(2, 1)
      # computer.board.add_O(3, 1)
      # computer.board.add_O(4, 1)
      # computer.board.add_O(5, 1)
    end

    #confirms the computer can play multiple times in each column
    it 'can add a piece on top of another' do
      computer = Computer.new(board)
      computer.drop("C")
      computer.drop("C")
      expect(board.lines[1][2]).to eq("O ")

    end
  end
end
