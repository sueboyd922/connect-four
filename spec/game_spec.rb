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
    xit 'prints a welcome message' do
      game = Game.new
      expect{game.start}.to output(
        <<~EXPECTED
        Welcome to Connect 4!
        Press any key to begin
        (but only Q if you're a quitter!)
        EXPECTED
      ).to_stdout
    end

    xit 'allows you to quit the game' do
      game = Game.new
      game.start
      want_to_play = "Q"
      #want to prove you can quit and gives a message

      #start new game
    end

  end

  describe "winning situations" do
    it 'can have a vertical winner' do
      game = Game.new
      game.board.add_X(0, 0)
      game.board.add_X(1, 0)
      game.board.add_X(2, 0)
      game.board.add_X(3, 0)
      # require 'pry'; binding.pry
      expect(game.winner?(game.player)).to be true
    end

    it 'can have a horizontal winner' do
      game = Game.new
      game.board.add_O(2, 2)
      game.board.add_O(2, 3)
      game.board.add_O(2, 4)
      game.board.add_O(2, 5)
      expect(game.winner?(game.computer)).to be true
    end

    it 'can have a diagonal to the right winner' do
      game = Game.new
      game.board.add_X(3, 3)
      game.board.add_X(4, 4)
      game.board.add_X(5, 5)
      game.board.add_X(2, 2)
      expect(game.winner?(game.player)).to be true
    end

    it 'can have a diagonal to the left winner' do
      game = Game.new
      game.board.add_O(5, 1)
      game.board.add_O(4, 2)
      game.board.add_O(3, 3)
      game.board.add_O(2, 4)
      expect(game.winner?(game.computer)).to be true
    end
  end



    # test start method

    # test turn method, game ends with 42 pieces, games ends if there's a winner

    # test winner? method

    # horional check method

    # vertical method

    # diagonal check method

end
