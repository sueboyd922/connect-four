require 'rspec'
require './lib/smart_board'

describe SmartBoard do
  describe '#initialize' do
    it 'exists' do
      smart_board = SmartBoard.new
      expect(smart_board).to be_an_instance_of(SmartBoard)
    end

    it 'is initialized with a set of columns' do
      smart_board = SmartBoard.new
      # require 'pry'; binding.pry
      expect(smart_board.valid_columns).to eq({"A"=>[0, 0], "B"=>[0, 1], "C"=>[0, 2], "D"=>[0, 3], "E"=>[0, 4], "F"=>[0, 5], "G"=>[0, 6]})
    end

    it 'creates a set of 42 objects of the cell class' do
      smart_board = SmartBoard.new
      expect(smart_board.cells.count).to eq(42)
    end

    it 'creates a board of 6 lines and 7 columns' do
      smart_board = SmartBoard.new
      expect(smart_board.full_board.count).to eq(6)
      expect(smart_board.valid_columns.count).to eq(7)
    end
  end

  describe '#print_board' do
    it 'the board starts out blank' do
      smart_board = SmartBoard.new
      expect{smart_board.print_board}.to output(
        <<~EXPECTED
        A B C D E F G\n. . . . . . . \n. . . . . . . \n. . . . . . . \n. . . . . . . \n. . . . . . . \n. . . . . . . \n-------------
        EXPECTED
      ).to_stdout
    end


  end
end
