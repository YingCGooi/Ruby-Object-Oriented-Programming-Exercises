class TTTGame
  CONSOLE_WIDTH = 80
  attr_reader :board, :human, :players

  def initialize
    # @board = Board.new
    # @players = [Human.new('X'), Computer.new('O')]
  end

  def bannerize(message)
    puts '=' * CONSOLE_WIDTH
    center_print(message)
    puts '=' * CONSOLE_WIDTH
  end

  def center_print(message)
    puts message.center(CONSOLE_WIDTH)
  end

  def display_welcome_message
    bannerize "Welcome to Tic-Tac-Toe Expansion!"
  end

  def choice_or_default(choice, default_marker)
    choice.empty? ? default_marker : choice
  end

  def game_set_up
    puts "Before we begin, let's set up the game..."
    prompt_and_initialize_players
    prompt_and_update_player_markers
    prompt_and_update_player_names
  end

  def prompt_and_initialize_players
    choice = nil
    loop do
      puts "Select game mode (leave blank for default mode 0):"
      puts "(0) Board: 3x3 | Players: Human, Computer"
      puts "(1) Board: 5x5 | Players: Human, Computer"
      puts "(2) Board: 5x5 | Players: Human, Computer, Computer"
      puts "(3) Board: 5x5 | Players: Human, Human, Computer"
      choice = gets.chomp
      break if (0..3).include? choice.to_i
      puts "Invalid input, please enter a number (1-3)..."
    end

  @players =
    case choice.to_i
    when (0..1) then [Human.new('X'), Computer.new('O')]
    when 2 then [Human.new('X'), Computer.new('O'), Computer.new('V')]
    when 3 then [Human.new('X'), Human.new('O'), Computer.new('V')]
    end

  @board =
    case choice.to_i
    when 0 then Board.new(3)
    when 1..3 then Board.new(5)
    end
    p [@board, @players]
  end

  def prompt_and_update_player_markers
    human_choice =
      loop do
        puts "Input your one-character marker: (leave empty for 'X' default)"
        choice = gets.chomp
        break choice_or_default(choice, 'X') if choice.size <= 1
        puts "Invalid input, must be one character or empty..."
      end
    markers = %w[O]
    computer_choice =
      human_choice == 'O' ? 'X' : 'O'

    @players.each do |player|
      if player.class == Human
        player.marker = human_choice
      else
        player.marker = computer_choice
      end
    end

  end

  def clear_screen; system("clear") || system("cls"); end

  def play
    clear_screen
    display_welcome_message
    game_set_up

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

class Board
  def initialize(size)
    @size = size
  end
end

class Player
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end
end

class Human < Player

end

class Computer < Player

end

game = TTTGame.new
game.play