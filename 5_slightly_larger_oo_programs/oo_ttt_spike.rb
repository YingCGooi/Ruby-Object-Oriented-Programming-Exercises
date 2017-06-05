class Board
  INITIAL_MARKER = ' '

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }
    # {1 => ' ', 2=> ' ', 3=> ' '...}
  end

  def get_square_at(key)
    @squares[key]
  end
end

class Square
  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  def initialize(marker)
    @marker = marker # encapsulating the state of the marker
  end

  def mark
  end
end

class TTTGame
  attr_reader :board

  def initialize
    @board = Board.new # represent the state of board
    @human = Player.new("X")
    @computer = Player.new("O")
  end

  def human_moves
    puts "Chooes a square between 1-9: "
    loop do
      square = gets.chomp.to_i
      break if (1..9).include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board.set_square_at(num, marker, human)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  | #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  | #{board.get_square_at(6)}"

    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  | #{board.get_square_at(9)}"

    puts "     |     |"
  end

  def play
    display_welcome_message
    loop do
      display_board
      human_moves
      break if someone_won? || board_full?

      computer_moves
      break if someone_won? || board_full?
    end
    # display_result
    # display_goodbye_message
  end
end

game = TTTGame.new
game.play