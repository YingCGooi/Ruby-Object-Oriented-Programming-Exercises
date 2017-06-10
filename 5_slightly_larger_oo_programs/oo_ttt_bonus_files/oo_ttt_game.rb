require_relative 'displayable'
require_relative 'board'
require_relative 'player'
require_relative 'human'
require_relative 'computer'

class TTTGame
  attr_reader :board, :human, :players

  include Displayable

  def initialize
    display_welcome_message
    choice = get_game_mode_choice
    @players = initialize_players(choice)
    @board = initialize_board(choice)
    display_game_initialized
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
        return if board.full? # || board.someone_won?
      end
    end
  end

  def display_game_initialized
    alert "Game starting..."
    sleep 3
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

# board = Board.new(5)
# Human.new.move(board)
# Computer.new.move(board)
# board.draw
game = TTTGame.new
game.play