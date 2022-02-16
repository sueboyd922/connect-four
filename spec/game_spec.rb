require './lib/game.rb'
require 'rspec'

describe Game do
  describe '#initialize' do
    it 'exists' do
      game = Game.new
      expect(game).to be_an_instance_of(Game)
    end

    it 'initalizes a board, player and computer class' do
      game = Game.new
      expect(game.player).to be_an_instance_of(Player)
      expect(game.board).to be_an_instance_of(Board)
      expect(game.computer).to be_an_instance_of(Computer)
    end

    it 'starts with zero pieces played, board empty' do
      game = Game.new
      expect(game.board.board_full?).to be false
    end
  end

  describe "winning situations" do
    it 'can have a vertical winner' do
      game = Game.new
      player = Player.new(game.board)
      game.board.add_X(0, 0)
      game.board.add_X(1, 0)
      game.board.add_X(2, 0)
      game.board.add_X(3, 0)
      game.game_type = "one player"
      letters = "X X X X"
      # when check_for_vertical is false it means that the array collecting winning combinations is not empty, aka there is a winner!
      expect(game.check_for_vertical(letters)).to be false
      expect(game.winner?(player)).to be true
    end

    it 'can have a horizontal winner' do
      game = Game.new
      computer = Computer.new(game.board)
      game.board.add_O(2, 2)
      game.board.add_O(2, 3)
      game.board.add_O(2, 4)
      game.board.add_O(2, 5)
      game.game_type = "one player"
      letters = "O O O O"
      # when check_for_horizontal is false it means that the array collecting winning combinations is not empty, aka there is a winner!
      expect(game.check_for_horizontal(letters)).to be false
      expect(game.winner?(computer)).to be true
    end

    it 'can have a diagonal to the right winner' do
      game = Game.new
      player = Player.new(game.board)
      game.board.add_X(3, 3)
      game.board.add_X(4, 4)
      game.board.add_X(5, 5)
      game.board.add_X(2, 2)
      game.game_type = "one player"
      letters = "X X X X"
      # when check_for_diagonal is false it means that the array collecting winning combinations is not empty, aka there is a winner!
      expect(game.check_for_diagonal(letters)).to be false
      expect(game.winner?(player)).to be true
    end

    it 'can have a diagonal to the left winner' do
      game = Game.new
      computer = Computer.new(game.board)
      game.board.add_O(5, 1)
      game.board.add_O(4, 2)
      game.board.add_O(3, 3)
      game.board.add_O(2, 4)
      game.game_type = "one player"
      letters = "O O O O"
      # when check_for_diagonal is false it means that the array collecting winning combinations is not empty, aka there is a winner!
      expect(game.check_for_diagonal(letters)).to be false
      expect(game.winner?(computer)).to be true
    end

    it 'can end in a draw' do
      game = Game.new
      expect(game.board.board_full?).to be false
      3.times do
        game.player.drop("A", "X ")
        game.player.drop("B", "X ")
        game.player.drop("D", "X ")
        game.player.drop("F")
      end
      expect(game.board.board_full?).to be false
      3.times do
        game.computer.drop("A")
        game.computer.drop("B")
        game.computer.drop("D")
        game.computer.drop("E")
        game.computer.drop("F")
        game.computer.drop("G")
        game.computer.drop("C")
      end
      expect(game.board.board_full?).to be false
      3.times do
        game.player.drop("E", "X ")
        game.player.drop("C", "X ")
        game.player.drop("G", "X ")
      end
      expect(game.board.board_full?).to be true
      game.game_type = "one player"
      expect{game.turn}.to output("The board is full! It's a draw\n").to_stdout
    end
  end


end
