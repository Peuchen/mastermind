#Create a Game class
class Game
#Initialize a new game by setting up a board containing a random code
  def initialize
    protected
    @code = ""
    4.times {@code += rand(6).to_s}
  end
#Create a play method to start the game
  def play
    puts "The computer has generated a secret code. Please enter your first guess."
    player = Player.new
    self.check_guess(player.guess)
  end

  #Create a method that checks the guess
  def check_guess
    #If true: Print the random code and congratulate the player
    #If false: Give feedback on the guess
  end
end

#Create a Player class
class Player
#Create a method for the player to enter a guess
  def guess
  end

end