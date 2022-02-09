require 'pry'
require './lib/column'
require './lib/board'

class Computer
  #a computers is initialized with a board (I think should be the same board as the computer class, we will figure that out)
  def initialize(board)
    @board = board
    @random = num
  end

#Generates a random number for the computer
  def random_number
    @random=(rand*7).to_i
  end

#create hash to match number to letter
#match random number to letter
#store letter as variable & pass letter to validate method
  def randum_num_to_letter(num)
    num.map{("A".."G").to_a[rand(*7).to_i]}.join
  end

  # method to determine if the spot is playable
  def validate
    #does the board's valid columns hash have the same key as the computers number?
    if @board.valid_columns.keys.include?(@random)
      #if yes check the count of that column. Is it less than 6? If it's 6 then the column is full and it is invalid
      if @board.valid_columns[@random][0] == 6
        puts "Column full, choose again"
        random_number #sends turn back to computer
      #if it is less than 6 the computer can proceed to the drop method
      else
        drop(@random)
      end
    # if the input does not match a column it is invalid
    else
      puts "That's not a valid column, try again"
      random_number #kicks computer back to random_number
    end
  end

  # method adds computers piece to board
  def drop(random)
      #store the valid_columns input of count as row (this changes)
      row = @board.valid_columns[@random][0]
      #store the valid_columns input of index as column (this stays the same)
      column = @board.valid_columns[@random][1]
      #use the board method to add the new piece
      @board.add_O(row, column)
      #increase the count in the column used by 1 so that next time it drops above it
      @board.valid_columns[@random][0] += 1
      #print out the board with new piece
      @board.print_board
      #goes back to the computer for another guess (this will change when we have both user and computer playing)
      random_number
  end
end
