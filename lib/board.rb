require './lib/column'

class Board
    attr_reader :lines, :valid_columns, :columns, :diagonal_lines
    def initialize(columns)
      @lines = [
        [". ", ". ", ". ", ". ", ". ", ". ", "."],
        [". ", ". ", ". ", ". ", ". ", ". ", "."],
        [". ", ". ", ". ", ". ", ". ", ". ", "."],
        [". ", ". ", ". ", ". ", ". ", ". ", "."],
        [". ", ". ", ". ", ". ", ". ", ". ", "."],
        [". ", ". ", ". ", ". ", ". ", ". ", "."]
      ]
      #lines is a 2D array representing the board
      @columns = columns
      #columns is the array that is passed to a new board object
      @valid_columns = {}
      #after the method create_columns this hash holds all the column info (name, count, index)
      # @pieces_played = 0
      create_columns
      # spaces_taken
      # @diagonal_lines = [
      #   [@lines[2][0], @lines[3][1], @lines[4][2], @lines[5][3]],
      #   [@lines[1][0], @lines[2][1], @lines[3][2], @lines[4][3], @lines[5][4]],
      #   [@lines[0][0], @lines[1][1], @lines[2][2], @lines[3][3], @lines[4][4], @lines[5][5]],
      #   [@lines[0][1], @lines[1][2], @lines[2][3], @lines[3][4], @lines[4][5], @lines[5][6]],
      #   [@lines[0][2], @lines[1][3], @lines[2][4], @lines[3][5], @lines[4][6]],
      #   [@lines[0][3], @lines[1][4], @lines[2][5], @lines[3][6]]
      # ]


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
