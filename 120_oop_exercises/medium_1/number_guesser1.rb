class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100
  attr_accessor :num_guesses

  def initialize
    @num_guesses = MAX_GUESSES
    @player = Player.new
    @secret_num = rand(RANGE)
  end

  def display_num_guesses
    return puts "You have 1 guess remaining." if num_guesses == 1
    puts "You have #{num_guesses} guesses remaining."
  end

  def indicate_low_or_high
    puts "Your guess is too low." if player.current_guess < secret_num
    puts "Your guess is too high." if player.current_guess > secret_num
  end

  def display_result
    return puts "You win!" if player.win?(secret_num)
    puts "You are out of guesses. You lose."
  end

  def decrement_num_guesses; @num_guesses -= 1  end
  def out_of_guesses?;       @num_guesses <= 0  end

  def play
    loop do
      display_num_guesses
      player.guess(RANGE)
      indicate_low_or_high
      decrement_num_guesses
      break if player.win?(secret_num) || out_of_guesses?
      puts ""
    end
    display_result
  end

  private

  attr_reader :secret_num, :player
end

class Player
  attr_reader :current_guess

  def initialize; @current_guess = nil  end

  def valid_answer?(answer, range)
    range.cover?(answer.to_i) && answer.to_i.to_s == answer
  end

  def guess(range)
    @current_guess =
      loop do
        print "Enter a number between #{range.first} and #{range.last}: "
        answer = gets.chomp
        break answer.to_i if valid_answer?(answer, range)
        print "Invalid guess. "
      end
  end

  def win?(secret_num); @current_guess == secret_num  end
end

game = GuessingGame.new
game.play