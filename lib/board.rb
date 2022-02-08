require './lib/column'

class Board
    attr_reader :lines, :valid_columns
    def initialize(columns)
      @lines = [
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "],
        [". ", ". ", ". ", ". ", ". ", ". ", ". "]
      ]
      @columns = columns
      @valid_columns = {}

    end

    def create_columns
       @columns.map do |column|
            @valid_columns[column.name] = [column.count, column.index]
                      end
    end


    def print_board
      puts "A B C D E F G"
      board = @lines.reverse.map do |line|
              line.map do |space|
                print space
              end
              puts ""
            end
    end

    def add_X(row, column)
      @lines[row][column] = "X "
    end

    def add_O(row, column)
      @lines[row][column] = "O "
    end
end
