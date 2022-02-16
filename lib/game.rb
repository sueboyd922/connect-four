require './lib/player'
require './lib/computer'

class Game
  attr_reader :player, :computer, :board
  attr_accessor :game_type #we know we should not use attr_accessor but when we added the two person option for the game we had to add it in order to access the game_type and manipulate it for the tests

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
    @game_type = nil #game_type starts as nil, to be determined in which_type
  end

  #this method will kickstart the game!
  def intro
    puts "Welcome to Connect 4!"
    puts "Press any key to begin"
    puts "(but only Q if you're a quitter!)"
    want_to_play = gets.chomp #any key to go, except Q will quit
    if want_to_play.upcase == "Q"
      puts "Ok bye then"
    else
      puts ""
      puts "Would you like to play against the computer or a friend?"
      @tries = 0 #this is here to give players 3 tries to get this answer right before quitting
      which_type
    end
  end

  def which_type
    puts "Type '1' for friend and '2' for computer!"
    @game_choice = gets.chomp #stores which choice user has made
    @tries += 1
    start
  end

  def start
    #if they want to play against a friend!
    if @game_choice == "1"
      print "Enter first player's name: "
      p1_name = gets.chomp
      print "Enter second player's name: "
      p2_name = gets.chomp
      @player_one = Player.new(@board, p1_name)#create two players
      @player_two = Player.new(@board, p2_name)
      puts "#{@player_one.name} will go first as X, #{@player_two.name} will be O"
      @player_one.board.print_board
      @game_type = "two player" #stores game type
      turn #begins the game!
    #if they want to play against the computer (comp and player already initialized when game was created)
    elsif @game_choice == "2"
      puts ""
      puts "You will be playing against the computer!"
      puts "You can go first :)"
      @player.board.print_board
      @game_type = "one player" #stores game type
      turn
    else
      if @tries == 3 #if they keep hitting the wrong keys, forced to quit
        puts "This really isn't that hard..."
      else
        puts "Invalid entry"
        which_type #kicks them back to make a decision again
      end
    end
  end

  def turn
    #all depends on which type of game! one or two player
    case @game_type
    #with one player the computer is random and player chooses column
    when "one player"
      until @board.board_full? #game stops if board is full w/o a winner
        @player.turn
        break if @player.quit == true # stops game if player wants to quit
        break if winner?(@player) == true # stops game if the player won!
        @computer.random_letter #computer random choice!
        break if winner?(@computer) == true #stops if computer wins the game
      end
      if @player.quit == true # inspirational message for someone who can't hack it against a less than intelligent computer opponent
        puts "You miss 100% of the shots you don't take...quitter"
      end
      #when game is over one message will print out
      if @board.board_full?
        puts "The board is full! It's a draw"
      elsif winner?(@player)
        puts "You beat a dumb computer...congrats"
      elsif winner?(@computer)
        puts "The computer beat you...sad"
      end

    # in the case of two live human players
    when "two player"
      until @board.board_full?
        puts "#{@player_one.name}'s turn!!"
        @player_one.turn # player one and if single player there is no letter passed on, it will default to X
        break if @player_one.quit == true #option to quit
        break if winner?(@player_one)
        puts "#{@player_two.name}'s turn!!"
        @player_two.turn("O ")# the second player will be O so it gets passed along to the methods inside the players turn
        break if @player_two.quit == true
        break if winner?(@player_two)
      end

      # message that will print out when game is over
      if @board.board_full?
        puts "No one wins! It's a draw!"
      elsif winner?(@player_one)
        puts "#{@player_one.name} rules! #{@player_two.name} drools!"
        puts "#{@player_one.name} won in #{@player_one.moves} moves!"
      elsif winner?(@player_two)
        puts "#{@player_two.name} rules! #{@player_two.name} drools!"
        puts "#{@player_two.name} won in #{@player_two.moves} moves!"
      end
    end
  end

  #this method determines if there is a winner!!
  def winner?(whose_turn)
    #searches for winner based on whose turn it is!
    case @game_type
    when "one player"
      if whose_turn.instance_of?(Player) #if player class they look for Xs
        letters = "X X X X"
      else
        letters = "O O O O" #if computer not they looks for Os
      end
    when "two player"
      if whose_turn == @player_one
        letters = "X X X X"
      else
        letters = "O O O O" #player_two will always have O's
      end
    end

  #this series of checks searches the board for any connects
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
    connect.empty? #if connect array is empty then there was no connects found, will return true. if connect array is *not* empty there is a winning combo and will return false. (counter intuitive lol)
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
    @bl = @board.lines #quick save this to a shorter variable for hard coding the diagonal options
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
