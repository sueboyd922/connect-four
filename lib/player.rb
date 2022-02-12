require './lib/column'
require './lib/board'

class Player
  attr_reader :board, :quit
  #a player is initialized with a board (I think should be the same board as the computer class, we will figure that out)
  def initialize(board)
    @board = board
    @quit = false
  end

  #when it's the players turn they get to type in a letter to play
  def get_input
    puts "Where would you like to play?"
    puts "Enter a letter A - G (Q to quit)"
    @input = gets.chomp
    @input.upcase!
    if @input == "Q"
      puts "Thanks for playing!"
      @quit = true
    else
      validate(@input) #takes the input to the validate method
    end
  end

  # method to determine if the spot is playable
  def validate(input)
    #does the board's valid columns hash have the same key as the input the player gave?
    if @board.valid_columns.keys.include?(input)
      #if yes check the count of that column. Is it less than 6? If it's 6 then the column is full and it is invalid
      if @board.valid_columns[input][0] == 6
        puts "Column full, choose again"
        get_input #sends user back to get_input
      #if it is less than 6 the input can proceed to the drop method
      else
        drop(input)
      end
    # if the input does not match a column it is invalid
    else
      puts "That's not a valid column, try again"
      get_input #kicks user back to get_input
    end
  end

  # method adds players piece to board
  def drop(input)
    # require 'pry'; binding.pry
      #store the valid_columns input of count as row (this changes)
      row = @board.valid_columns[input][0]
      #store the valid_columns input of index as column (this stays the same)
      column = @board.valid_columns[input][1]
      #use the board method to add the new piece
      @board.add_X(row, column)
      #increase the count in the column used by 1 so that next time it drops above it
      @board.valid_columns[input][0] += 1
      #print out the board with new piece
      @board.print_board
      #goes back to user_input for another guess (this will change when we have both user and computer playing)
  end

  def check_for_horizontal
    connect = @board.lines.select do |column|
            column.join.include?("X X X X")
          end
    connect.empty?
  end

  def check_for_vertical
    column_check = @board.lines.transpose
    connect = column_check.select do |column|
            column.join.include?("X X X X")
          end
    connect.empty?
  end

  def diagonal
    diagonal_lines = [
      [@board.lines[2][0], @board.lines[3][1], @board.lines[4][2], @board.lines[5][3]],
      [@board.lines[1][0], @board.lines[2][1], @board.lines[3][2], @board.lines[4][3], @board.lines[5][4]],
      [@board.lines[0][0], @board.lines[1][1], @board.lines[2][2], @board.lines[3][3], @board.lines[4][4], @board.lines[5][5]],
      [@board.lines[0][1], @board.lines[1][2], @board.lines[2][3], @board.lines[3][4], @board.lines[4][5], @board.lines[5][6]],
      [@board.lines[0][2], @board.lines[1][3], @board.lines[2][4], @board.lines[3][5], @board.lines[4][6]],
      [@board.lines[0][3], @board.lines[1][4], @board.lines[2][5], @board.lines[3][6]],
      [@board.lines[3][0], @board.lines[2][1], @board.lines[1][2], @board.lines[0][3]],
      [@board.lines[4][0], @board.lines[3][1], @board.lines[2][2], @board.lines[1][3], @board.lines[0][4]],
      [@board.lines[5][0], @board.lines[4][1], @board.lines[3][2], @board.lines[2][3], @board.lines[1][4], @board.lines[0][5]],
      [@board.lines[5][1], @board.lines[4][2], @board.lines[3][3], @board.lines[2][4], @board.lines[1][5], @board.lines[0][6]],
      [@board.lines[5][2], @board.lines[4][3], @board.lines[3][4], @board.lines[2][5], @board.lines[1][6]],
      [@board.lines[5][3], @board.lines[4][4], @board.lines[3][5], @board.lines[2][6]]
    ]
    # diagonal = @board.diagonal_lines
    # require 'pry'; binding.pry
    connect = diagonal_lines.select do |column|
            column.join.include?("X X X X")
          end
    connect.empty?
  end

  def winner?
    if diagonal == false
      return true
    elsif check_for_horizontal == false
      return true
    elsif check_for_vertical == false
      return true
    end
  end

end
