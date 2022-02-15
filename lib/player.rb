require './lib/column'
require './lib/board'
require 'pry'

# This defines the player class
class Player
  attr_reader :board, :quit, :valid
  #a player is initialized with a board
  def initialize(board)
    @board = board
    @quit = false
    @valid = false
  end

  def turn
    @valid = false
    until @valid == true
        get_input
        break if @quit == true
        validate(@input, letter)
      end
    unless @quit == true
      if letter == "X "
        drop(@input, "X ")
      else
        drop(@input, "O ")
    end
  end

  # when it's the players turn they get to type in a letter to play
  def get_input(letter = "X ")
    puts "Where would you like to play?"
    puts "Enter a letter A - G (Q to quit)"
    @input = gets.chomp
    @input.upcase!
    if @input == "Q"
      @quit = true
      puts "Thanks for playing!"
    end

  end

  # method to determine if the spot is playable
  def validate(input, letter)
    # does the board's valid columns hash have the same key as the input the player gave?
    if @board.valid_columns.keys.include?(input)
      # if yes check the count of that column. Is it less than 6? If it's 6 then the column is full and it is invalid
      if @board.valid_columns[input][0] == 6
        puts "Column full, choose again"
        @valid = false #sends user back to get_input
      # if it is less than 6 the input can proceed to the drop method
      else
        @valid = true
      end
    # if the input does not match a column it is invalid
    else
      puts "That's not a valid column, try again"
      @valid = false #kicks user back to get_input
    end
  end

  # method adds players piece to board
  def drop(input)
    # require 'pry'; binding.pry
      # store the valid_columns input of count as row (this changes)
      row = @board.valid_columns[input][0]
      # store the valid_columns input of index as column (this stays the same)
      column = @board.valid_columns[input][1]
      # use the board method to add the new piece
      if letter = "X "
        @board.add_X(row, column)
        # increase the count in the column used by 1 so that next time it drops above it
      else
        @board.add_O(row, column)
      end
      @board.valid_columns[input][0] += 1
      # print out the board with new piece
      @board.print_board
      # goes back to user_input for another guess (this will change when we have both user and computer playing)
  end

end




  def turn
    @valid = false
    until @valid == true
        get_input
        break if @quit == true
        validate(@input)
      end
    unless @quit == true
      drop(@input)
    end
  end

  # when it's the players turn they get to type in a letter to play
  def get_input(letter = "X ")
    puts "Where would you like to play?"
    puts "Enter a letter A - G (Q to quit)"
    @input = gets.chomp
    @input.upcase!
    if @input == "Q"
      @quit = true
    else
      validate(@input, letter) #takes the input to the validate method
    end
  end

  # method to determine if the spot is playable
  def validate(input, letter)
    #does the board's valid columns hash have the same key as the input the player gave?
    if @board.valid_columns.keys.include?(input)
      #if yes check the count of that column. Is it less than 6? If it's 6 then the column is full and it is invalid
      if @board.valid_columns[input][0] == 6
        puts "Column full, choose again"
        @valid = false #sends user back to get_input
      # if it is less than 6 the input can proceed to the drop method
      else
        if letter == "X "
          drop(input, "X ")
        else
          drop(input, "O ")
        end
        @valid = true
      end
    else
      puts "That's not a valid column, try again"
      @valid = false
    end
  end

  # method adds players piece to board
  def drop(input, letter)
    row = @board.valid_columns[input][0]
    #store the valid_columns input of index as column (this stays the same)
    column = @board.valid_columns[input][1]
    if letter == "X "
        #store the valid_columns input of count as row (this changes)
      #use the board method to add the new piece
      @board.add_X(row, column)
    else
      @board.add_O(row, column)
    end
      #increase the count in the column used by 1 so that next time it drops above it
    @board.valid_columns[input][0] += 1
    @board.print_board
  end

end
