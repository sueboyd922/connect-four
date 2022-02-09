require './lib/column'
require './lib/board'

class Player
  #a player is initialized with a board (I think should be the same board as the computer class, we will figure that out)
  def initialize(board)
    @board = board
  end

  #when it's the players turn they get to type in a letter to play
  def get_input
    puts "Where would you like to play?"
    @input = gets.chomp
    validate #takes the input to the validate method
  end

  # method to determine if the spot is playable
  def validate
    #does the board's valid columns hash have the same key as the input the player gave?
    if @board.valid_columns.keys.include?(@input)
      #if yes check the count of that column. Is it less than 6? If it's 6 then the column is full and it is invalid
      if @board.valid_columns[@input][0] == 6
        puts "Column full, choose again"
        get_input #sends user back to get_input
      #if it is less than 6 the input can proceed to the drop method
      else
        drop(@input)
      end
    # if the input does not match a column it is invalid
    else
      puts "That's not a valid column, try again"
      get_input #kicks user back to get_input
    end
  end

  # method adds players piece to board
  def drop(input)
      #store the valid_columns input of count as row (this changes)
      row = @board.valid_columns[@input][0]
      #store the valid_columns input of index as column (this stays the same)
      column = @board.valid_columns[@input][1]
      #use the board method to add the new piece
      @board.add_X(row, column)
      #increase the count in the column used by 1 so that next time it drops above it
      @board.valid_columns[@input][0] += 1
      #print out the board with new piece
      @board.print_board
      #goes back to user_input for another guess (this will change when we have both user and computer playing)
      get_input
  end
end