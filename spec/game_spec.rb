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





end
