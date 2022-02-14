require './lib/player'
require './lib/computer'

class Game
  attr_reader :player, :computer

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
    puts "Welcome to Connect 4!"
    puts "Press any key to begin"
    puts "(but only Q if you're a quitter!)"
    want_to_play = gets.chomp
    #creates a board and then a player and computer that have access to that board
    @board = Board.new(valid_columns)
    @player = Player.new(@board)
    @computer = Computer.new(@board)
    #game starts with zero pieces played
    @pieces_played = 0
    #option to quit the game before it starts
    if want_to_play.upcase == "Q"
      puts "Ok bye then"
    else #otherwise on to start!!
      start
    end
  end

  #this method will kickstart the game!
  def start
    puts "You will be playing against the computer!"
    puts "You can go first :)"
    @player.board.print_board
    turn #on to the meat of the game!
  end

  def turn
    # game will continue until 42 pieces have been played if there is no winner and the game will be a draw
    until @pieces_played == 42
      @player.get_input # this starts the chain of getting info, checking that it is a valid choice, adding it to the board and then printing the new board
      @pieces_played += 1 #one more piece played!
      break if @player.quit == true #if player ever types Q game is quit
      break if winner?(@player) == true #if the player wins, game over
      @computer.random_letter # starts the chain of getting a random letter from the computer and if column not full, adds to the board and prints updated board
      @pieces_played += 1
      break if winner?(@computer) == true #game over if computer wins
    end

    #when game ends whichever option is true prints out!
    if @pieces_played == 42
      puts "The board is full! It's a draw"
    elsif winner?(@player)
      puts "You beat a dumb computer...congrats"
    elsif winner?(@computer)
      puts "The computer beat you...sad"
    end
  end

  #this method determines if there is a winner!!
  def winner?(whose_turn)
    if whose_turn.instance_of?(Player) #if player class they look for Xs
      letters = "X X X X"
    else
      letters = "O O O O" #if not they looks for Os
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
