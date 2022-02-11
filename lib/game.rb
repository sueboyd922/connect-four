require './lib/player'
require './lib/computer'

class Game
  attr_reader :player, :computer, :pieces_played

  def initialize
    a = Column.new("A", 0)
    b = Column.new("B", 1)
    c = Column.new("C", 2)
    d = Column.new("D", 3)
    e = Column.new("E", 4)
    f = Column.new("F", 5)
    g = Column.new("G", 6)
    valid_columns = [a, b, c, d, e, f, g]
    @board = Board.new(valid_columns)
    @player = Player.new(@board)
    @computer = Computer.new(@board)
    # @player = player
    # @computer = computer
    @pieces_played = 0
    start
  end

  def start
    puts "Welcome to Connect Four!"
    puts "You will be playing against the computer!"
    puts "You can go first :)"
    # @player.board.create_columns
    @player.board.print_board
    turn
  end

  def turn
    # require 'pry'; binding.pry
    until @pieces_played == 42
      @player.get_input
      @pieces_played += 1
      break if @player.quit == true
      @computer.random_letter
      @pieces_played += 1
    end
    if @pieces_played == 42
      puts "The board is full! It's a draw"
    end
  end



    # break if there's a winner
    #
    # game over method
    # ask if you want to replay?


end

game = Game.new
