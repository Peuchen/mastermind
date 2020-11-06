class Game
  $win = false

  def initialize
    @code = ""
    4.times {@code += rand(6).to_s}
  end

  def play
    puts "The computer has generated a secret code."
    player = Guesser.new
    #2 instead of 12 for test purposes
    12.times do |turn|
      puts "------\nTurn #{turn+1}\n------"
      check_guess(player.guess)
      break if $win === true
      puts "You've lost. The code was #{@code}." if turn === 11
    end
  end

  def check_guess(num)
    if num === @code
      puts "The code was indeed #{num}. Congratulations!"
      $win = true
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

class Guesser
  def guess
    puts "Please enter your guess, consisting of 4 numbers between 0 and 5."
    @input = gets.chomp
    until @input.length === 4 && /([0-5][0-5][0-5][0-5])/.match?(@input)
      puts "Your input does not consist of 4 numbers between 0 and 5. Please try again."
      @input = gets.chomp
    end
    @input
  end
end

game = Game.new
game.play