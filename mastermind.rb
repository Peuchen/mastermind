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
    #2 instead of 12 for test purposes
    2.times do |turn|
      puts "------\nTurn #{turn+1}\n------"
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
      feedback(num, @code)
    end
  end

  def feedback(guess, code)
    exact_match = 0
    correct_num = 0
    code.split('').each_with_index do |n, idx|
      if n === guess[idx]
        guess[idx] = "-"
        exact_match += 1
      elsif guess.include?(n)
        guess = guess.sub(n, "-")
        correct_num += 1
      end
    end
    puts "There are #{exact_match} exact matches and #{correct_num} correct numbers."
  end
end

#Create a Player class
class Player
#Create a method for the player to enter a guess
  def guess
    puts "Please enter your guess, consisting of 4 numbers between 0 and 5."
    @input = gets.chomp
    until input.length === 4 && /([0-5][0-5][0-5][0-5])/.match?(input)
      puts "Your input does not consist of 4 numbers between 0 and 5. Please try again."
      @input = gets.chomp
    end
    @input
  end
end

game = Game.new
game.play