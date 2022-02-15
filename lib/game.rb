require './lib/player'
require './lib/computer'

class Game
  attr_reader :player, :computer, :board, :pieces_played
  attr_accessor :winner

  def initialize
    # creates all the columns
    a = Column.new("A", 0)
    b = Column.new("B", 1)
    c = Column.new("C", 2)
    d = Column.new("D", 3)
    e = Column.new("E", 4)
    f = Column.new("F", 5)
    g = Column.new("G", 6)
    #columns into an array that get turned into a hash in the board class
    valid_columns = [a, b, c, d, e, f, g]
    #creates a board and then a player and computer that have access to that board
    @board = Board.new(valid_columns)
    @player = Player.new(@board)
    @computer = Computer.new(@board)

    #game starts with zero pieces played
    @pieces_played = 0
  end

  #this method will kickstart the game!
  def intro
    puts "Welcome to Connect 4!"
    puts "Press any key to begin"
    puts "(but only Q if you're a quitter!)"
    want_to_play = gets.chomp
    if want_to_play.upcase == "Q"
      puts "Ok bye then"
    else
      puts "Would you like to play against the computer or a friend?"
      @tries = 0
      which_type
    end
  end

  def which_type
    puts "Type '1' for friend and '2' for computer!"
    @game_type = gets.chomp
    @tries += 1
    start
  end

  def start
    if @game_type == "1"
      @player_one = Player.new(@board)
      @player_two = Player.new(@board)
      puts "Player One will go first as X, player Two will be O"
      @player_one.board.print_board
      @game_type = :two_player
      turn
    elsif @game_type == "2"
      puts "You will be playing against the computer!"
      puts "You can go first :)"
      @player = Player.new(@board)
      @computer = Computer.new(@board)
      @player.board.print_board
      @game_type = :one_player
      turn
    else
      if @tries == 3
        "You just don't get it..."
      else
        puts "Invalid entry"
        which_type
      end
    end
  end

  def turn
    case @game_type
    when :one_player
      until @player.board.board_full?
        @player.get_input
        @pieces_played += 1
        break if @player.quit == true
        break if winner?(@player) == true
        @computer.random_letter
        @pieces_played += 1
        break if winner?(@computer) == true
      end
      if @player.board.board_full?
        puts "The board is full! It's a draw"
      elsif winner?(@player)
        puts "You beat a dumb computer...congrats"
      elsif winner?(@computer)
        puts "The computer beat you...sad"
      end

    when :two_player
      until @player.board.board_full?
        @player_one.get_input
        @pieces_played += 1
        break if @player_one.quit == true
        break if winner?(@player_one)
        @player_two.get_input("O ")
        @pieces_played += 1
        break if @player_two.quit == true
        break if winner?(@player_two)
      end
      if @player.board.board_full?
        puts "No one wins! It's a draw!"
      elsif winner?(@player_one)
        puts "Player 1 wins!"
      elsif winner?(@player_two)
        puts "Player 2 wins!"
      end
    end
  end

  #this method determines if there is a winner!!
  def winner?(whose_turn)
    case @game_type
    when :one_player
      if whose_turn.instance_of?(Player) #if player class they look for Xs
        letters = "X X X X"
      else
        letters = "O O O O" #if not they looks for Os
      end
    when :two_player
      if whose_turn == @player_one
        letters = "X X X X"
      else
        letters = "O O O O"
      end
    end

    if check_for_diagonal(letters) == false
      return true
    elsif check_for_horizontal(letters) == false
      return true
    elsif check_for_vertical(letters) == false
      return true
    end
  end

  #sweeps through each row for 4 in a row
  def check_for_horizontal(letters)
    connect = @board.lines.select do |column|
          column.join.include?(letters)
        end
    connect.empty?
  end

  #swaps columns and rows and sweeps through each column for 4 in a row
  def check_for_vertical(letters)
    column_check = @board.lines.transpose
    connect = column_check.select do |column|
            column.join.include?(letters)
          end
    connect.empty?
  end

  #this dooozy: array of diagonal rows with at least 4 spaces. and then same method to sweep through these lines for 4 in a row
  def check_for_diagonal(letters)
    @bl = @board.lines
    diagonal_lines = [
      [@bl[2][0], @bl[3][1], @bl[4][2], @bl[5][3]],
      [@bl[1][0], @bl[2][1], @bl[3][2], @bl[4][3], @bl[5][4]],
      [@bl[0][0], @bl[1][1], @bl[2][2], @bl[3][3], @bl[4][4], @bl[5][5]],
      [@bl[0][1], @bl[1][2], @bl[2][3], @bl[3][4], @bl[4][5], @bl[5][6]],
      [@bl[0][2], @bl[1][3], @bl[2][4], @bl[3][5], @bl[4][6]],
      [@bl[0][3], @bl[1][4], @bl[2][5], @bl[3][6]],
      [@bl[3][0], @bl[2][1], @bl[1][2], @bl[0][3]],
      [@bl[4][0], @bl[3][1], @bl[2][2], @bl[1][3], @bl[0][4]],
      [@bl[5][0], @bl[4][1], @bl[3][2], @bl[2][3], @bl[1][4], @bl[0][5]],
      [@bl[5][1], @bl[4][2], @bl[3][3], @bl[2][4], @bl[1][5], @bl[0][6]],
      [@bl[5][2], @bl[4][3], @bl[3][4], @bl[2][5], @bl[1][6]],
      [@bl[5][3], @bl[4][4], @bl[3][5], @bl[2][6]]
      ]

      connect = diagonal_lines.select do |column|
          column.join.include?(letters)
          end
      connect.empty?
    end
end
