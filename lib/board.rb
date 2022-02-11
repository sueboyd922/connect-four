require './lib/column'

class Board
    attr_reader :lines, :valid_columns, :columns, :pieces_played
    def initialize(columns)
      @lines = [
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "]
      ]
      #lines is a 2D array representing the board
      @columns = columns
      #columns is the array that is passed to a new board object
      @valid_columns = {}
      #after the method create_columns this hash holds all the column info (name, count, index)
      # @pieces_played = 0
      create_columns
      # spaces_taken


    end

    #this method creates the hash of columns
    # valid_columns = {key(name) => values[count, index]}
    # the key is the string letter name and the value is an array with index[0] being the count and index[1] being the column it corresponds with
    def create_columns
       @columns.map do |column|
            @valid_columns[column.name] = [column.count, column.index]
                      end
    end

    #this method prints the board
    #the .reverse makes it print upside down so that the X and O get dropped at the bottom of the board
    def print_board
      puts "A B C D E F G"
      board = @lines.reverse.map do |line|
              line.map do |space|
                print space
              end
              puts ""
            end
    end

    #this method will be used to add the players pieces
    #takes in the row and column corresponding to the place the piece will fall
    def add_X(row, column)
      @lines[row][column] = "X "
    end

    #this method will be used to add the computer's pieces
    #same idea as the X but instead replaces with an O
    def add_O(row, column)
      @lines[row][column] = "O "
    end

    # def spaces_taken
    #     @valid_columns.each do |name, info|
    #     @pieces_played += info[0]
    #   end
    #   @pieces_played
    # end

end
