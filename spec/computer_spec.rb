require './lib/computer.rb'
require 'rspec'
require 'pry'

a = Column.new("A", 0)
b = Column.new("B", 1)
c = Column.new("C", 2)
d = Column.new("D", 3)
e = Column.new("E", 4)
f = Column.new("F", 5)
g = Column.new("G", 6)

columns=[a, b, c, d, e, f, g]

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
      computer = Computer.new(board)

      expect(computer.board.valid_columns.keys.include?(computer.random_letter)).to be true
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
    it "Only plays letter if column is not full" do
      computer = Computer.new(board)
      6.times do
        computer.drop("B")
        # require 'pry'; binding.pry
      end
      expect(computer.validate(computer.random_letter)).not_to eq("B")
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
