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
    puts "Welcome to Connect 4!"
    puts "Press any key to begin"
    puts "(but only Q if you're a quitter!)"
    want_to_play = gets.chomp
    @board = Board.new(valid_columns)
    @player = Player.new(@board)
    @computer = Computer.new(@board)
    @pieces_played = 0
    if want_to_play.upcase == "Q"
      puts "Ok bye then"
    else
      start
    end
  end

  def start
    puts "Welcome to Connect Four!"
    puts "You will be playing against the computer!"
    puts "You can go first :)"
    @player.board.print_board
    turn
  end

  def turn
    until @pieces_played == 42
      @player.get_input
      @pieces_played += 1
      break if @player.quit == true
      break if winner?(@player) == true
      @computer.random_letter
      @pieces_played += 1
      break if winner?(@computer) == true
    end
    if @pieces_played == 42
      puts "The board is full! It's a draw"
    elsif winner?(@player)
      puts "You beat a dumb computer...congrats"
    elsif winner?(@computer)
      puts "The computer beat you...sad"
    end
  end

  def winner?(whose_turn)
    if whose_turn.instance_of?(Player)
      letters = "X X X X"
    else
      letters = "O O O O"
    end

    if check_for_diagonal(letters) == false
      return true
    elsif check_for_horizontal(letters) == false
      return true
    elsif check_for_vertical(letters) == false
      return true
    end
  end

  def check_for_horizontal(letters)
    connect = @board.lines.select do |column|
          column.join.include?(letters)
        end
    connect.empty?
  end

  def check_for_vertical(letters)
    column_check = @board.lines.transpose
    connect = column_check.select do |column|
            column.join.include?(letters)
          end
    connect.empty?
  end

  def check_for_diagonal(letters)
    diagonal_lines = [
      [@board.lines[2][0], @board.lines[3][1], @board.lines[4][2], @board.lines[5][3]],
      [@board.lines[1][0], @board.lines[2][1], @board.lines[3][2], @board.lines[4][3], @board.lines[5][4]],
      [@board.lines[0][0], @board.lines[1][1], @board.lines[2][2], @board.lines[3][3], @board.lines[4][4], @board.lines[5][5]],
      [@board.lines[0][1], @board.lines[1][2], @board.lines[2][3], @board.lines[3][4], @board.lines[4][5], @board.lines[5][6]],
      [@board.lines[0][2], @board.lines[1][3], @board.lines[2][4], @board.lines[3][5], @board.lines[4][6]],
      [@board.lines[0][3], @board.lines[1][4], @board.lines[2][5], @board.lines[3][6]],
      [@board.lines[3][0], @board.lines[2][1], @board.lines[1][2], @board.lines[0][3]],
      [@board.lines[4][0], @board.lines[3][1], @board.lines[2][2], @board.lines[1][3], @board.lines[0][4]],
      [@board.lines[5][0], @board.lines[4][1], @board.lines[3][2], @board.lines[2][3], @board.lines[1][4], @board.lines[0][5]],
      [@board.lines[5][1], @board.lines[4][2], @board.lines[3][3], @board.lines[2][4], @board.lines[1][5], @board.lines[0][6]],
      [@board.lines[5][2], @board.lines[4][3], @board.lines[3][4], @board.lines[2][5], @board.lines[1][6]],
      [@board.lines[5][3], @board.lines[4][4], @board.lines[3][5], @board.lines[2][6]]
      ]

      connect = diagonal_lines.select do |column|
          column.join.include?(letters)
          end
      connect.empty?
    end
end

game = Game.new
