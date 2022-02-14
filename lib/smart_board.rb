require './lib/cell'
require './lib/column'

class SmartBoard
  attr_reader :full_board, :columns, :cells, :valid_columns

  def initialize
    a = Column.new("A", 0)
    b = Column.new("B", 1)
    c = Column.new("C", 2)
    d = Column.new("D", 3)
    e = Column.new("E", 4)
    f = Column.new("F", 5)
    g = Column.new("G", 6)
    @columns = [a, b, c, d, e, f, g]
    @valid_columns = {}
    create_columns
    @cells = []
    [0, 1, 2, 3, 4, 5, 6].map do |column|
      @row = 0
      6.times do
        @cells.push(Cell.new(@row, column))
        @row += 1
      end
    end

    @full_board = {
      0 => [],
      1 => [],
      2 => [],
      3 => [],
      4 => [],
      5 => [] }

    @cells.map do |cell|
      @full_board[cell.row].push(cell)
    end

  end

  def create_columns
     @columns.map do |column|
          @valid_columns[column.name] = [column.count, column.index]
                    end
  end

  def print_board
    puts "A B C D E F G"
    @full_board.values.reverse.map do |row|
      row.each do |cell|
        print cell.display
      end
      puts ""
    end
    puts "-" * 13
  end

  def add_X(row, column)
    @full_board[row][column].display = "X "
    @full_board[row][column].occupied = true
  end

  def add_O(row, column)
    @full_board[row][column].display = "O "
    @full_board[row][column].occupied = true
  end


end

board = SmartBoard.new
board.add_X(0, 0)
board.print_board

# require 'pry'; binding.pry
8 * 1
