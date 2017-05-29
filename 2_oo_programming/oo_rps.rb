class RPSGame
  CONSOLE_WIDTH = 60
  attr_accessor :human, :computer, :score_board

  def initialize
    @computer = Computer.new
    display_welcome_message
    @human = Human.new
    @score_board = []
  end

  def display_welcome_message
    bannerize "I am #{computer.name}. Welcome to Rock, Paper, Scissors!"
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
    ai_move = computer.move
    human_move = human.move
    if human_win?
      p_ctr "#{human_move} beats #{ai_move}"
      p_ctr "#{human.name} won this turn."
    elsif computer_win?
      p_ctr "#{ai_move} beats #{human_move}"
      p_ctr "#{computer.name} won this turn."
    else
      p_ctr "It's a tie! \n"
    end
    puts "=" * CONSOLE_WIDTH
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
    human.score += 1 if human_win?
    computer.score += 1 if computer_win?
    @score_board << [human.move, computer.move, human_win?, computer_win?]
    computer.adjust_weights(@score_board)
  end

  def human_win?
    human.move > computer.move
  end

  def computer_win?
    computer.move > human.move
  end

  def display_row(str1, str2, str3)
    row = "#{str1.rjust(12)} | #{str2.center(5)} | #{str3.ljust(12)}"
    puts row.center(CONSOLE_WIDTH)
  end

  def display_score_data
    score_board.each_with_index do |(move, ai_move, win, ai_win), idx|
      result = win ? "x #{move}" : move.to_s
      ai_result = ai_win ? "#{ai_move} x" : ai_move.to_s
      display_row(result, (idx + 1).to_s, ai_result)
    end
  end

  def display_score_board
    display_row(human.name.to_s, "Round", computer.name.to_s)
    puts "----------+-------+----------".center(CONSOLE_WIDTH)
    display_score_data
    puts score_board_padding
  end

  def score_board_padding
    "\n" * [20 - score_board.size, 0].max
  end

  def display_scores
    display_score_board
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
    self.score_board = []
    human.score = 0
    computer.score = 0
  end

  def exceed_max_score?
    [human.score, computer.score].max >= 10
  end

  def play
    loop do
      reset_score
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
      break unless play_again?
    end
    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
  end

  def clear_screen
    system("clear") || system("cls")
  end

  def instantiate(choice)
    move_name = choice.to_s.capitalize
    move_subclass = Object.const_get(move_name)
    move_subclass.new
  end
end

class Human < Player
  def set_name
    self.name =
      loop do
        puts "Please enter your name:"
        n = gets.chomp
        break n.capitalize unless n.empty? || !n[/[a-z]/i]
        puts "Name cannot be empty and must contain a letter..."
      end
  end

  def valid_choice?(choice)
    Move::VALUES.include?(choice)
  end

  def parse_input(val) # retrieve move by index/full move name
    return val.downcase.to_sym if val.to_i == 0
    Move::VALUES[val.to_i - 1]
  end

  def choose
    self.move =
      loop do
        print "#{name.capitalize}, please choose "
        puts "(1)Rock, (2)Paper, (3)Scissors, (4)Spock, (5)Lizard:"
        p choice = parse_input(gets.chomp)
        break instantiate(choice) if valid_choice?(choice)
        puts "Invalid choice, please try again..."
      end
    clear_screen
  end
end

class Computer < Player
  attr_accessor :move_weights
  attr_reader :move_prob_ranges

  def initialize
    super
    @move_weights = { rock: 10, paper: 10, scissors: 10, spock: 10, lizard: 10 }
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Sonny', 'EVE'].sample
  end

  def adjust_weights(score_board)
    p score_board.to_s + "is the score board"
  end

  def weighted_choice
    sum = 0
    weight_ranges =
      move_weights.map do |move, prob|
        [move, (sum + 1..sum += prob)]
      end .to_h # {:rock=>1..3, :paper=>4..6, ...}

    random_num = rand(1..sum)
    weight_ranges.keys.find do |move|
      weight_ranges[move].include?(random_num)
    end # returns the selected move symbol
  end

  def choose
    self.move = instantiate(weighted_choice)
  end
end

class Move
  VALUES = [:rock, :paper, :scissors, :spock, :lizard]
  attr_reader :value

  def initialize # DRY on subclasses
    move_class = self.class
    @value = move_class.to_s
    # returns 'ROCK' when subclass is Rock
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
