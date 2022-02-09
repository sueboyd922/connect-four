require './lib/column'
require './lib/board'

class Player

  def initialize(board)
    @board = board
  end

  def get_input
    puts "Where would you like to play?"
    @input = gets.chomp
    validate
  end
    # require 'pry'; binding.pry
  def validate
    if @board.valid_columns.keys.include?(@input)
      if @board.valid_columns[@input][0] == 6
        puts "Column full, choose again"
        get_input
      else
        drop(@input)
      end
    else
      puts "That's not a valid column, try again"
      get_input
    end
  end

  def drop(input)
      row = @board.valid_columns[@input][0]
      column = @board.valid_columns[@input][1]
      @board.add_X(row, column)
      @board.valid_columns[@input][0] += 1
      @board.print_board
      get_input
  end
end
