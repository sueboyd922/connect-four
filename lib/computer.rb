require 'pry'
require './lib/column'
require './lib/board'

class Computer
  #a computers is initialized with a board (I think should be the same board as the computer class, we will figure that out)
  attr_reader :board
  def initialize(board)
    @board = board
  end

#Generates a random number for the computer
  def random_letter
    @computer_input = @board.valid_columns.keys.sample
  end

  # method to determine if the spot is playable
  def validate
      #if yes check the count of that column. Is it less than 6? If it's 6 then the column is full and it is invalid
      if @board.valid_columns[@computer_input][0] == 6
        random_letter#sends turn back to computer
      #if it is less than 6 the computer can proceed to the drop method
      else
        drop(@computer_input)
      end
  end

  # method adds computers piece to board
  def drop(random)
      #store the valid_columns input of count as row (this changes)
      row = @board.valid_columns[@computer_input][0]
      #store the valid_columns input of index as column (this stays the same)
      column = @board.valid_columns[@computer_input][1]
      #use the board method to add the new piece
      @board.add_O(row, column)
      #increase the count in the column used by 1 so that next time it drops above it
      @board.valid_columns[@computer_input][0] += 1
      #print out the board with new piece
      @board.print_board
      #goes back to the computer for another guess (this will change when we have both user and computer playing)
      # random_letter
  end
end
