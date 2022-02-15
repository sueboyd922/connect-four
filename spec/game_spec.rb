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

    it 'starts with zero pieces played' do
      game = Game.new
      expect(game.pieces_played).to eq(0)
    end
  end

  describe '#start' do
    xit 'allows you to quit the game at the start' do
      game = Game.new
      expect{game.start}.to output("Welcome to Connect 4!\nPress any key to begin").to_stdout

      # expect{want_to_play = "Q"}.to output("Ok bye then").to_stdout
    end
  end

  describe "winning situations" do
    it 'can have a vertical winner' do
      game = Game.new
      game.board.add_X(0, 0)
      game.board.add_X(1, 0)
      game.board.add_X(2, 0)
      game.board.add_X(3, 0)
      # when check_for_vertical is false it means that the array collecting winning combinations is not empty, aka there is a winner!
      expect(game.check_for_vertical("X X X X")).to be false
      expect(game.winner?(game.player)).to be true

    end

    it 'can have a horizontal winner' do
      game = Game.new
      game.board.add_O(2, 2)
      game.board.add_O(2, 3)
      game.board.add_O(2, 4)
      game.board.add_O(2, 5)
      # when check_for_horizontal is false it means that the array collecting winning combinations is not empty, aka there is a winner!
      expect(game.check_for_horizontal("O O O O")).to be false
      expect(game.winner?(game.computer)).to be true
    end

    it 'can have a diagonal to the right winner' do
      game = Game.new
      game.board.add_X(3, 3)
      game.board.add_X(4, 4)
      game.board.add_X(5, 5)
      game.board.add_X(2, 2)
      # when check_for_diagonal is false it means that the array collecting winning combinations is not empty, aka there is a winner!
      expect(game.check_for_diagonal("X X X X")).to be false
      expect(game.winner?(game.player)).to be true
    end

    it 'can have a diagonal to the left winner' do
      game = Game.new
      game.board.add_O(5, 1)
      game.board.add_O(4, 2)
      game.board.add_O(3, 3)
      game.board.add_O(2, 4)
      # when check_for_diagonal is false it means that the array collecting winning combinations is not empty, aka there is a winner!
      expect(game.check_for_diagonal("O O O O")).to be false
      expect(game.winner?(game.computer)).to be true
    end

    it 'can end in a draw' do
      game = Game.new
      expect(game.board.board_full?).to be false
      3.times do
        game.player.drop("A")
        game.player.drop("B")
        game.player.drop("D")
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
        game.player.drop("E")
        game.player.drop("C")
        game.player.drop("G")
      end
      # require 'pry'; binding.pry
      expect(game.board.board_full?).to be true
      expect{game.turn}.to output("The board is full! It's a draw\n").to_stdout
    end
  end


end
