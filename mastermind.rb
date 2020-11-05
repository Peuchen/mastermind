#Create a Game class
class Game
#Initialize a new game by setting up a board containing a random code

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
      player.guess
      if check_guess(@guessed_code)
        break
      end
    end
  end

  #Create a method that checks the guess
  def check_guess(num)
    #If true: Print the random code and congratulate the player
    if num === @code
      puts "The code indeed was #{num}. Congratulations!"
    #If false: Give feedback on the guess
    else
      puts "No such luck."
      feedback(num, @code)
    end
  end

  def feedback(guess, code)
  end
end

#Create a Player class
class Player
  attr_reader :guessed_code
#Create a method for the player to enter a guess
  def guess
    puts "Please enter your guess, consisting of 4 numbers from 0 to 5."
    @guessed_code = gets.chomp
  end
end

game = Game.new
game.play