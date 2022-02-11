require './lib/player'
require './lib/computer'

class Game
  attr_reader :player, :computer

  def initialize(player, computer)
    @player = player
    @computer = computer
    @turns = 0
  end

  def start
    puts "Welcome to Connect Four!"
    puts "You will be playing against the computer!"
    puts "You can go first :)"
    # @player.board.create_columns
    @player.board.print_board
  end

  def turn
    # require 'pry'; binding.pry
    # until @board.pieces_played == 42
      @player.get_input
      @computer.board.spaces_taken
      # @player.board.print_board
      @computer.random_letter
      # @computer.board.print_board
  end

  def pieces_played
    @player.board.valid_columns.map do |name, info|
      pieces += info[0]
    end
  end

    # break if there's a winner
    #
    # game over method
    # ask if you want to replay?


end

A = Column.new("A", 0)
B = Column.new("B", 1)
C = Column.new("C", 2)
D = Column.new("D", 3)
E = Column.new("E", 4)
F = Column.new("F", 5)
G = Column.new("G", 6)
valid_columns = [A, B, C, D, E, F, G]


@board = Board.new(valid_columns)
player = Player.new(@board)
computer = Computer.new(@board)
game = Game.new(player, computer)
game.start


require 'pry'; binding.pry

7 + 8
