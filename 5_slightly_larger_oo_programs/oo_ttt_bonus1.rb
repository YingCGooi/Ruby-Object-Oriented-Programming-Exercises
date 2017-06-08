module Displayable
  CONSOLE_WIDTH = 80

  private
  def bannerize(message, style = "=")
    puts style * CONSOLE_WIDTH
    center_print(message)
    puts style * CONSOLE_WIDTH
  end

  def center_print(message)
    puts message.center(CONSOLE_WIDTH)
  end

  def prompt(message)
    puts ">> #{message}"
  end

  def capitalize_words(str)
    str.split.map(&:capitalize).join(' ')
  end

  def alert(message)
    puts "<!>...#{message}..."
  end

  def display_player_created
    bannerize("#{self.class} player created!" \
    " Name =>'#{self.name}' | Marker =>'#{self.marker}'", '-')
  end
end

class TTTGame
  attr_reader :board, :human, :players

  include Displayable

  def initialize
    display_welcome_message
    choice = get_game_mode_choice
    @players = initialize_players(choice)
    @board = initialize_board(choice)
  end

  def initialize_players(choice)
    case choice
    when 0..1 then [Human.new, Computer.new]
    when 2 then [Human.new, Computer.new, Computer.new]
    when 3 then [Human.new, Human.new, Computer.new]
    end
  end

  def initialize_board(choice)
    case choice
    when 0 then Board.new(3)
    when 1..3 then Board.new(5)
    end
  end

  def get_game_mode_choice
    alert "Before we begin, let's set up the game"
    puts ""
    loop do
      prompt "Select game mode (leave blank for default mode 0):"
      puts "  (0) Board: 3x3 | Players: Human, Computer"
      puts "  (1) Board: 5x5 | Players: Human, Computer"
      puts "  (2) Board: 5x5 | Players: Human, Computer, Computer"
      puts "  (3) Board: 5x5 | Players: Human, Human, Computer"
      choice = gets.chomp
      return choice.to_i if (%W[#{''} 0 1 2 3]).include? choice
      alert "Invalid input, please enter a number between (1-3)"
    end
  end

  def display_welcome_message
    bannerize "Welcome to Tic-Tac-Toe Expansion!"
  end

  def clear_screen; system("clear") || system("cls"); end

  def display_board
    players.each {|x| print [x.class, x.name, x.marker]}
    puts ""
    board.draw
    puts ""
  end

  def players_move_until_board_full_or_win
    loop do
      players.each do |player|
        player.move(board)
        return if board.full || board.someone_won?
      end
    end
  end

  def play
    clear_screen
    loop do
      display_board

      loop do
        players_move_until_board_full_or_win
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end
end

class Board
  INITIAL_MARKER = ' '
  attr_reader :size, :squares, :winning_lines
  def initialize(size)
    @size = size
    @squares = [INITIAL_MARKER] * (size ** 2)
    @win_lines = calculate_win_lines
  end

  def draw
    puts "     |" * (size - 1)
    squares.map.with_index do |square, idx|
      if (idx + 1) % size != 0
        print "  #{square}  |"
      else
        puts "  #{square}"
        puts "     |" * (size - 1)
        if idx < (size ** 2) - 1
          puts "-----+" * (size - 1) + "-----"
          puts "     |" * (size - 1)
        end
      end
    end
  end

  def unmarked_sq_nums
    squares.map.with_index do |sq, idx|
      sq == INITIAL_MARKER ? (idx + 1) : nil
    end.compact
  end

  def []=(num, marker)
    @squares[num] = marker
  end

  def full?
    unmarked_sq_nums.empty?
  end

  def calculate_win_lines
    sq_nums = (1..size ** 2).to_a
    rows =
      sq_nums.each_cons(size).map.with_index do |(*row), idx|
        row if idx % size == 0
      end.compact

    cols =
      rows.first.zip(*rows[1..-1])

    diagonals =
      [
        (0...rows.size).map { |i| rows[i][i] },
        (0...rows.size).map { |i| rows[i][rows.size - 1 - i] }
      ]

    p rows + cols + diagonals
  end
end

class Player
  include Displayable

  @@created_markers = { human: [], computer: [] }
  @@names = ['R2D2', 'Hal', 'Sonny']
  @@marker_list = %w[X O V N]
  attr_reader :name, :marker
end

class Human < Player
  def initialize
    @name = prompt_name
    @marker = prompt_input_marker
    display_player_created
    update_player_states
  end

  def update_player_states
    @@names << @name
    @@marker_list.delete(@marker)
    @@created_markers[:human] << @marker
  end

  def invalid_name?(n)
    n.empty? || !n[/[a-z]/i] || @@names.include?(capitalize_words(n))
  end

  def human_count
    @@created_markers[:human].count
  end

  def second_or_nothing
    human_count > 0 ? " ##{human_count + 1}" : ""
  end

  def prompt_name
    loop do
      puts ""
      prompt "Human player#{second_or_nothing}, please enter your name:"
      n = gets
      return capitalize_words(n.chomp) unless invalid_name?(n.chomp)
      alert "Name cannot be the same or empty and must contain a letter"
    end
  end

  def valid_marker?(choice)
    choice.size <= 1 && !dup_marker?(choice)
  end

  def dup_marker?(choice)
    @@created_markers[:human].include?(choice)
  end

  def prompt_input_marker
    puts ""
    prompt "Welcome #{name}!"
    loop do
      prompt "Please enter any single character to designate your marker:"
      alert "Or hit enter to select default marker '#{@@marker_list[0]}'"
      c = gets.chomp
      return choice_or_default(c, @@marker_list[0]) if valid_marker?(c.upcase)
      if dup_marker?(c)
        alert "Invalid input, cannot be the same marker created"
      else
        alert "Invalid input, has to be empty or a single character"
      end
    end
  end

  def choice_or_default(choice, default_marker)
    choice.empty? ? default_marker : choice.upcase
  end

  def move(board)
    puts "Choose a square between #{board.unmarked_sq_nums.join(', ')}: "
    square =
      loop do
        n = gets.chomp.to_i
        break n if board.unmarked_sq_nums.include?(n)
        alert "Sorry, that's not a valid choice"
      end
    board[square] = self.marker
  end
end

class Computer < Player
  def initialize
    @name = @@names.delete(@@names[0..2].sample)
    @marker = @@marker_list.shift
    # get the first remaining marker from list
    @@created_markers[:computer] << @marker
    display_player_created
  end

  def move(board)
    choice = board.unmarked_sq_nums.sample
    board[choice] = self.marker
  end
end

board = Board.new(5)
Human.new.move(board)
Computer.new.move(board)
board.draw
# game = TTTGame.new
# game.play