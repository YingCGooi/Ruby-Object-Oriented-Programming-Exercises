class RPSGame
  CONSOLE_WIDTH = 60
  attr_accessor :human, :computer, :score_board

  def initialize
    display_welcome_message
    @human = Human.new
    @score_board = []
  end

  def display_welcome_from_ai
    puts "Hi #{human.name}, I am #{computer.bot.name}. Let's begin..."
  end

  def display_welcome_message
    bannerize "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    bannerize "Thanks for playing Rock, Paper, Scissors, Lizard, Spock!"
  end

  def bannerize(message)
    puts "=" * CONSOLE_WIDTH
    puts_center(message)
    puts "=" * CONSOLE_WIDTH
  end

  def puts_center(message)
    puts message.center(CONSOLE_WIDTH)
  end

  def display_moves
    puts_center("#{human.name} chose #{human.move} |"\
      " #{computer.bot.name} chose #{computer.bot.move}")
  end

  def display_winner
    ai_move = computer.bot.move
    human_move = human.move
    if human_win?
      puts_center "#{human_move} beats #{ai_move}"
      puts_center "#{human.name} won this turn."
    elsif computer_win?
      puts_center "#{ai_move} beats #{human_move}"
      puts_center "#{computer.bot.name} won this turn."
    else
      puts_center "It's a tie! \n"
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

    answer.downcase == 'y'
  end

  def count_scores
    human.score += 1 if human_win?
    computer.score += 1 if computer_win?
    @score_board << [human.move, computer.bot.move, human_win?, computer_win?]
    computer.bot.adjust_weights(@score_board)
  end

  def human_win?
    human.move > computer.bot.move
  end

  def computer_win?
    computer.bot.move > human.move
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
    puts "=" * CONSOLE_WIDTH
    display_row(human.name.to_s, "Round", computer.bot.name)
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
    "#{computer.bot.name}'s score is #{computer.score}")
  end

  def display_final_winners
    if human.score > computer.score
      bannerize "YOU WON THE GAME!"
    else
      bannerize "GAME OVER! #{computer.bot.name} WON!"
    end
  end

  def reset_game
    reset_computer
    self.score_board = []
    human.score = 0
    computer.score = 0
  end

  def reset_computer
    @computer = Computer.new
    display_welcome_from_ai
  end

  def exceed_human_computer_max_score?
    [human.score, computer.score].max >= 10
  end

  def play
    loop do
      reset_game
      loop do
        human.choose
        computer.bot.choose
        display_moves
        display_winner
        count_scores
        display_scores
        break if exceed_human_computer_max_score?
      end
      display_final_winners
      break unless play_again?
    end
    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
    set_name
  end

  def clear_screen
    system("clear") || system("cls")
  end

  def instantiate_move(choice)
    case choice
    when :rock then Rock.new
    when :paper then Paper.new
    when :scissors then Scissors.new
    when :lizard then Lizard.new
    when :spock then Spock.new
    end
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
        puts "#{name.capitalize}, please choose move by number or full name:"
        puts "(1)Rock, (2)Paper, (3)Scissors, (4)Spock, (5)Lizard:"
        choice = parse_input(gets.chomp)
        break instantiate_move(choice) if valid_choice?(choice)
        puts "Invalid choice, please try again..."
      end
    clear_screen
  end
end

class Computer < Player
  attr_accessor :move_weights
  attr_reader :move_prob_ranges, :bot
  BOTS = ['Easy', 'Medium', 'Hard']

  def initialize
    super
    reset_weights
  end

  def set_name
    choose_difficulty
  end

  def choose_difficulty
    @bot =
      loop do
        puts "Please select difficulty: "
        puts "  (1)Easy/Randomized - R2D2"
        puts "  (2)Medium/A little smart - Hal"
        puts "  (3)Hard/Intelligent - Sonny"
        num = gets.chomp.to_i
        break Object.const_get(BOTS[num - 1]).new if (1..3).cover?(num)
        puts "Please choose a number (1-3)..."
      end
  end

  def obj_to_sym(move_obj)
    move_obj.value.downcase.to_sym
  end

  def reset_weights
    @move_weights = {
      rock: 100, paper: 100, scissors: 100, spock: 100, lizard: 100
    }
  end

  def enemy(move)
    Move::VALUES.select do |move_sym|
      instantiate_move(move_sym) > instantiate_move(move.value)
    end
  end

  def adjust_weights(score_board); end

  def increase_enemy_move(score_board)
    mv, _ = score_board.last
    enemy(mv).each do |move|
      key = @move_weights[move]
      key < 110 ? @move_weights[move] += 60 : @move_weights[move] += 10
    end
  end

  def weighted_choice
    sum = 1
    weight_ranges =
      move_weights.map do |move, prob|
        [move, (sum...sum += prob)]
      end.to_h # {:rock=>1..100, :paper=>101..200, ...}

    random_num = rand(1..sum.to_f)

    weight_ranges.keys.find do |move|
      weight_ranges[move].include?(random_num)
    end # returns the selected move symbol
  end

  def choose
    # p @move_weights
    self.move = instantiate_move(weighted_choice)
  end
end

class Easy < Computer
  def initialize
    @name = 'R2D2'
    reset_weights
  end

  def choose
    self.move = instantiate_move(Move::VALUES.sample)
  end
end

class Medium < Computer
  def initialize
    @name = 'Hal'
    reset_weights
  end

  def adjust_weights(score_board)
    increase_enemy_move(score_board)
  end
end

class Hard < Computer
  def initialize
    @name = 'Sonny'
    reset_weights
  end

  def adjust_weights(score_board)
    score_board.each do |human_mv, ai_mv, human_win, ai_win|
      if human_win
        @move_weights[obj_to_sym(ai_mv)] *= 0.60
        @move_weights[obj_to_sym(ai_mv)] += 20
      end
      @move_weights[obj_to_sym(human_mv)] *= 0.8 if !human_win && !ai_win
    end
    increase_enemy_move(score_board)
  end
end

class Move
  VALUES = [:rock, :paper, :scissors, :spock, :lizard]
  attr_reader :value

  def initialize; end

  def to_s
    @value.to_s.capitalize
  end
end

class Rock < Move
  def initialize; @value = :rock; end

  def >(other_move)
    %i[scissors lizard].include?(other_move.value)
  end
end

class Paper < Move
  def initialize; @value = :paper; end

  def >(other_move)
    %i[rock spock].include?(other_move.value)
  end
end

class Scissors < Move
  def initialize; @value = :scissors; end

  def >(other_move)
    %i[lizard paper].include?(other_move.value)
  end
end

class Lizard < Move
  def initialize; @value = :lizard; end

  def >(other_move)
    %i[paper spock].include?(other_move.value)
  end
end

class Spock < Move
  def initialize; @value = :spock; end

  def >(other_move)
    %i[rock scissors].include?(other_move.value)
  end
end

RPSGame.new.play
