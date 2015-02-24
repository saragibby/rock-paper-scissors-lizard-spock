require_relative 'models/game'
require_relative 'models/player'
require_relative 'models/computer_player'

number_of_rounds = 3

def print_123_shoot
  sleep_time = 0.05
  (1..3).each do |i|
    print i
    print_3_dots(sleep_time)
  end
  puts "\n"
end

def print_3_dots(sleep_time)
  (1..3).each do |i|
    print '.'; sleep(sleep_time)
  end
end

# Get players name
puts "Let's play a game! Best of #{number_of_rounds}"
print "What is your name? "
player_name = STDIN.gets.chomp!

# Create new game
game = Game.new(player_name)
puts "\nHi #{player_name}!"

# Play rounds
(1..number_of_rounds).each do |round|
  puts "\n--- ROUND #{round} ---"
  choice_string = Game::CHOICES.map{ |k,v| "#{v[:name]}(#{k})" }.join(", ")
  print "Make selection: #{choice_string}? "
  game.player1.selection = STDIN.gets.chomp!

  until game.player1.valid? do
    print "Please select a valid choice: #{choice_string}: "
    game.player1.selection = STDIN.gets.chomp!
  end

  game.player2.pick
  print_123_shoot
  puts "  #{game.player1.name} picked: " + game.player1.selection_detail[:name]
  puts "  #{game.player2.name} picked: " + game.player2.selection_detail[:name]
  puts game.result
end

# Display final score
puts "\n--------- FINAL SCORE ---------"
puts "    #{game.player1.name}: #{game.player1.win_count}"
puts "    #{game.player2.name}: #{game.player2.win_count}"
puts "-------------------------------"
puts "  CHAMPION IS.... #{game.champion}"
puts "-------------------------------"
