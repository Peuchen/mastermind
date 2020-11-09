class Game

  $win = false
  $exact_match = 0
  $correct_num = 0

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
    $exact_match = 0
    $correct_num = 0
    @temp_guess = guess.dup
    code.split('').each_with_index do |n, idx|
      if n === @temp_guess[idx]
        @temp_guess[idx] = "-"
        $exact_match += 1
      elsif guess.include?(n)
        @temp_guess = @temp_guess.sub(n, "-")
        $correct_num += 1
      end
    end

    puts "There are #{$exact_match} exact matches and #{$correct_num} correct numbers."
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
  $computer_guess = "0000"
  $memory = ""

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
      puts $computer_guess
      check_guess($computer_guess)
      change_computer_guess($exact_match)
      break if $win === true
      puts "You've lost. The code was #{@code}." if turn === 11
    end
  end

  def change_computer_guess(exact_matches)
    if exact_matches > 0  && $memory.length < 4
      $memory << $computer_guess[0...exact_matches]
    end
    if $memory.length < 4
      $computer_guess = ($computer_guess.to_i + 1111).to_s
    else
      $computer_guess = $memory.chars.shuffle.join
    end
    puts "Memory is #{$memory}"
  end
end

game = Game.new
game.select_mode