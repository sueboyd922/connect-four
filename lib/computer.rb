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
    sleep([0, 1, 2].sample) #neat trick Kim and Joseph shared, the computer will pause for 0-2 seconds as if it's thinking. It's obviously not, this computer is stupid.
    @computer_input = @board.valid_columns.keys.sample # gets a random letter A-G from the column hash keys
    validate #checks to see if it's a playable column
    @computer_input
  end

  # method to determine if the spot is playable
  def validate
      #check to see if column is full or not
      if @board.valid_columns[@computer_input][0] == 6
        random_letter #sends turn back to computer
      #if it is less than 6 the computer can proceed to the drop method
      else
        drop(@computer_input)
        @computer_input
      end
  end

  # method adds computers piece to board
  def drop(random)
      #store the valid_columns input of count as row (this changes)
      row = @board.valid_columns[random][0]
      #store the valid_columns input of index as column (this stays the same)
      column = @board.valid_columns[random][1]
      #use the board method to add the new piece
      @board.add_O(row, column)
      #increase the count in the column used by 1 so that next time it drops above it
      @board.valid_columns[random][0] += 1
      #print out the board with new piece
      @board.print_board
  end
end
