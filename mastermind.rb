class Game
  $win = false

  def initialize
    @code = ""
    4.times {@code += rand(6).to_s}
  end

  def select_mode
    puts "Do you want to play Mastermind as the (c) code creator or as the (g) guesser?"
    @input = gets.chomp
    until @input === "c" || @input === "g"
      puts "You have not chosn 'c' or 'g'. Please try again."
      @input = gets.chomp
    end
    if @input === "c"
      creator = Creator.new
      creator.create_code
    elsif @input === "g"
      guesser = Guesser.new
      guesser.play
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
        exact_match += 1
      elsif guess.include?(n)
        guess = guess.sub(n, "-")
        correct_num += 1
      end
    end
    puts "There are #{exact_match} exact matches and #{correct_num} correct numbers."
  end
end

class Guesser < Game
  def play
    puts "The computer has generated a secret code."
    12.times do |turn|
      puts "------\nTurn #{turn+1}\n------"
      check_guess(guess)
      break if $win === true
      puts "You've lost. The code was #{@code}." if turn === 11
    end
  end

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

class Creator < Game
  def create_code
    puts "Please enter your secret code, consisting of 4 numbers between 0 and 5."
    @code = gets.chomp
    until @code.length === 4 && /([0-5][0-5][0-5][0-5])/.match?(@code)
      puts "Your input does not consist of 4 numbers between 0 and 5. Please try again."
      @code = gets.chomp
    end
    self.play
  end

  def play
    puts "The player has generated a secret code."
    12.times do |turn|
      puts "------\nTurn #{turn+1}\n------"
      check_guess(computer_guess)
      break if $win === true
      puts "You've lost. The code was #{@code}." if turn === 11
    end
  end

  def computer_guess
    computer_guess = ""
    4.times {computer_guess += rand(6).to_s}
    puts computer_guess
    computer_guess
  end
end

game = Game.new
game.select_mode