require './lib/column'
require './lib/board'
require 'pry'

# This defines the player class
class Player
  attr_reader :board, :quit, :valid, :name, :moves
  #a player is initialized with a board
  def initialize(board, name = "Human player")
    @board = board
    @name = name
    @quit = false
    @valid = false
    @moves = 0
  end

  #method for the player to place a piece
  def turn(letter = "X ") #default X unless specified (only specified in two player game for player_two)
    @valid = false #valid starts out false
    until @valid == true #once a valid letter is found it can move on
        get_input
        break if @quit == true
        validate(@input) #goes to see if the input can be played
      end
    unless @quit == true # option to quit at anytime
      if letter == "X " #default X to drop method once valid
        drop(@input, "X ")
      else
        drop(@input, "O ") #if letter is O in two player game
      end
    end
    @moves += 1 #keeps track of how many moves a player is making
  end

  # when it's the players turn they get to type in a letter to play
  def get_input
    puts "Where would you like to play?"
    puts "Enter a letter A - G (Q to quit)"
    @input = gets.chomp
    @input.upcase!
    if @input == "Q"
      @quit = true
    end
  end

  # method to determine if the spot is playable
  def validate(input)
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
  def drop(input, letter = "X ") #default letter X
      # store the valid_columns input of count as row (this changes)
      row = @board.valid_columns[input][0]
      # store the valid_columns input of index as column (this stays the same)
      column = @board.valid_columns[input][1]
      # use the board method to add the new piece
      if letter == "X "
        @board.add_X(row, column)
      else
        @board.add_O(row, column) # only used in two person game
      end
      #increase the count in the chosen column
      @board.valid_columns[input][0] += 1
      # print out the board with new piece
      @board.print_board
  end
end
