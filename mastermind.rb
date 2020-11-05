#Create a Game class
class Game
#Initialize a new game by setting up a board containing a random code
  $win = false

  def initialize
    @code = ""
    4.times {@code += rand(6).to_s}
  end
#Create a play method to start the game
public
def play
    puts "The computer has generated a secret code."
    player = Player.new
    12.times do
      check_guess(player.guess)
      break if $win === true
    end
  end

  #Create a method that checks the guess
  def check_guess(num)
    #If true: Print the random code and congratulate the player
    if num === @code
      puts "The code indeed was #{num}. Congratulations!"
      $win = true
    #If false: Give feedback on the guess
    else
      puts "No such luck."
      puts num
      feedback(num, @code)
    end
  end

  def feedback(guess, code)
    exact_match = 0
    correct_num = 0
    code.split('').each_with_index do |n, idx|
      if n === guess[idx]
        guess[idx] = "-"
        puts guess
        exact_match += 1
      elsif guess.include?(n)
        guess = guess.sub(n, "-")
        puts guess
        correct_num += 1
      end
    end
    puts "There are #{exact_match} exact matches and #{correct_num} correct numbers."
  end
end

#Create a Player class
class Player
  attr_reader :guess
#Create a method for the player to enter a guess
  def guess
    puts "Please enter your guess, consisting of 4 numbers between 0 and 5."
    input = gets.chomp
    until /([0-5][0-5][0-5][0-5])/.match?(input)
      puts "Your input does not consist of 4 numbers between 0 and 5. Please try again."
      input = gets.chomp
    end
    input
  end
end

game = Game.new
game.play