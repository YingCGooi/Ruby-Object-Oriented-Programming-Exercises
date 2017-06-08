class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagonals
  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
    # {1 => ' ', 2=> ' ', 3=> ' '...}
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw # we can reference instance variables directly here
    # we are not talking about reaching into an object from outside
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  # should only contain things related to the board
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares[0].marker if three_identical_markers?(squares)
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    marker_arr = squares.map(&:marker).uniq
    marker_arr.size == 1 && !marker_arr[0].strip.empty?
  end
end

class Square
  INITIAL_MARKER = ' '.freeze
  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER # get rid of namespace resolution
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker # encapsulating the state of the marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new # represent the state of board
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  private

  def human_moves
    puts "Chooes a square between #{board.unmarked_keys.join(', ')}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen
    system("clear") || system("cls")
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def display_board
    puts "You're a #{HUMAN_MARKER}. Computer is #{COMPUTER_MARKER}."
    puts ""
    board.draw
    puts ""
  end

  def computer_moves
    board[board.unmarked_keys.to_a.sample] = computer.marker
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker then puts "You won!"
    when computer.marker then puts "Computer won!"
    else puts "The board is full!"
    end
  end

  def play_again?
    answer =
      loop do
        puts "Would you like to play again? (y/n)"
        answer = gets.chomp.downcase
        break answer if %w[y n].include? answer
        puts "Sorry, must be y or n"
      end

    answer == 'y'
  end

  def reset
    board.reset
    @current_marker = HUMAN_MARKER
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  public

  def play
    clear_screen
    display_welcome_message

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
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

game = TTTGame.new
game.play
