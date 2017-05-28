class RPSGame
  CONSOLE_WIDTH = 60
  attr_accessor :human, :computer

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    bannerize "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    bannerize "Thanks for playing Rock, Paper, Scissors!"
  end

  def bannerize(message)
    puts "=" * CONSOLE_WIDTH
    p_ctr(message)
    puts "=" * CONSOLE_WIDTH
  end

  def p_ctr(message)
    puts message.center(CONSOLE_WIDTH)
  end

  def display_moves
    p_ctr("#{human.name} chose #{human.move} |"\
      " #{computer.name} chose #{computer.move}")
  end

  def display_winner
    if human.move > computer.move
      p_ctr "#{human.move} beats #{computer.move}"
      p_ctr "#{human.name} won this turn."
    elsif computer.move > human.move
      p_ctr "#{human.move} lost to #{computer.move}"
      p_ctr "#{computer.name} won this turn."
    else
      p_ctr "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Invalid input, must be 'y' or 'n'."
    end

    answer == 'y'
  end

  def count_scores
    if human.move > computer.move
      human.score += 1
    elsif computer.move > human.move
      computer.score += 1
    end
  end

  def display_scores
    bannerize("#{human.name}'s score is #{human.score} | "\
    "#{computer.name}'s score is #{computer.score}")
  end

  def display_final_winner
    if human.score > computer.score
      bannerize "YOU WON THE GAME!"
    else
      bannerize "GAME OVER! #{computer.name} WON!"
    end
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def exceed_max_score?
    [human.score, computer.score].max >= 10
  end

  def play
    loop do
      loop do
        human.choose
        computer.choose
        display_moves
        display_winner
        count_scores
        display_scores
        break if exceed_max_score?
      end
      display_final_winner
      reset_score
      break unless play_again?
    end
    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
    @score = 0
  end

  def clear_screen
    system("clear") || system("cls")
  end

  def instantiate(choice)
    move_name = choice.capitalize
    move_subclass = Object.const_get(move_name)
    move_subclass.new
  end
end

class Human < Player
  attr_accessor :score

  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Please enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      print "#{name.capitalize}, please choose "
      puts "(1)Rock, (2)Paper, (3)Scissors, (4)Spock, (5)Lizard:"
      input = gets.chomp
      choice = Move::VALUES[input.to_i] || input.upcase
      break if Move::VALUES[1..-1].include?(choice.upcase)
      puts "Sorry, invalid choice."
    end
    self.move = instantiate(choice)
    clear_screen
  end
end

class Computer < Player
  attr_accessor :score

  def set_name
    self.name = ['R2D2', 'Hal', 'Sonny', 'EVE'].sample
  end

  def choose
    self.move = instantiate(Move::VALUES[1..-1].sample)
  end
end

class Move
  attr_reader :value

  VALUES = [nil, 'ROCK', 'PAPER', 'SCISSORS', 'SPOCK', 'LIZARD']

  def initialize # DRY in subclasses
    move_class = self.class
    @value = move_class.to_s.upcase
    # 'ROCK' when subclass is Rock
  end

  def to_s
    @value
  end
end

class Rock < Move
  def >(other_move)
    %w[SCISSORS LIZARD].include?(other_move.value)
  end
end

class Paper < Move
  def >(other_move)
    %w[ROCK SPOCK].include?(other_move.value)
  end
end

class Scissors < Move
  def >(other_move)
    %w[LIZARD PAPER].include?(other_move.value)
  end
end

class Lizard < Move
  def >(other_move)
    %w[PAPER SPOCK].include?(other_move.value)
  end
end

class Spock < Move
  def >(other_move)
    %w[ROCK SCISSORS].include?(other_move.value)
  end
end

RPSGame.new.play
