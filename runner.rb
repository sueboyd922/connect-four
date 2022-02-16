require './lib/game'

again = nil
until again == "no"
  game = Game.new
  game.intro
  puts " "
  puts "Would you like to play again?"
  puts "Type 'no' if you are sick of this game!"
  again = gets.chomp
  again.downcase!
end
