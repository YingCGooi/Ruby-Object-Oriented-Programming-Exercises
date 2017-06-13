require 'pry'

class String # source: Stackoverflow
  def black;          "\033[30m#{self}\033[0m" end
  def red;            "\033[31m#{self}\033[0m" end
  def green;          "\033[32m#{self}\033[0m" end
  def yellow;         "\033[33m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
  def magenta;        "\033[35m#{self}\033[0m" end
  def cyan;           "\033[36m#{self}\033[0m" end
  def gray;           "\033[37m#{self}\033[0m" end
end

module Displayable
  CONSOLE_WIDTH = 80

  private

  def display_welcome_message
    bannerize "Welcome to Tic-Tac-Toe Expansion!"
  end

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
    puts "<!> #{message}..."
  end

  def display_player_created
    bannerize("#{self.class} player created!" \
    " Name =>'#{name}' | Marker =>'#{marker}'", '-')
  end

  def choice_or_default(choice, default_marker)
    choice.empty? ? default_marker : choice.upcase
  end

  def count_down_to_game_start
    alert "Game starting in...3"
    # sleep 1
    alert "...2"
    # sleep 1
    # alert "...1"
    # sleep 1
  end

  def display_goodbye_message
    bannerize "Thank you for playing Tic-Tac-Toe Expansion! Goodbye!"
  end

  def joinor(arr, delimiter=', ', word='or')
    before_last_words = arr.take(arr.size - 1).join(delimiter)
    case arr.size
    when 0    then ' '
    when 1    then arr.first.to_s
    when 2    then arr.join(" #{word} ")
    when 3..99 then before_last_words + " #{word} " + arr.last.to_s
    end
  end

  def clear_screen; system("clear") || system("cls"); end
end

class TTTGame
  WINNING_SCORE = 3
  attr_reader :board, :human, :players

  include Displayable

  def initialize
    display_welcome_message
    choice = prompt_game_mode_choice
    @players = initialize_players(choice)
    @board = initialize_board(choice)
    count_down_to_game_start
  end

  def initialize_players(choice)
    case choice
    when 0..1 then [Human.new, Computer.new]
    when 2 then [Human.new, Computer.new, Computer.new]
    when 3 then [Human.new, Human.new]
    when 4 then [Human.new, Computer.new]
    end
  end

  def initialize_board(choice)
    case choice
    when 0 then Board.new(3)
    when 1..3 then Board.new(5)
    when 4 then Board.new(9)
    end
  end

  def prompt_game_mode_choice
    alert "Before we begin, let's set up the game"
    puts ""
    loop do
      prompt "Select game mode (leave blank for default mode 0):"
      puts "  (0) Board: 3x3 | Matches: 3 | Players: Human, Computer"
      puts "  (1) Board: 5x5 | Matches: 4 | Players: Human, Computer"
      puts "  (2) Board: 5x5 | Matches: 4 | Players: Human, Computer, Computer"
      puts "  (3) Board: 5x5 | Matches: 4 | Players: Human, Human"
      puts "  (4) Board: 9x9 | Matches: 5 | Players: Human, Computer"
      choice = gets.chomp
      return choice.to_i if %W[#{''} 0 1 2 3 4].include? choice
      alert "Invalid input, please enter a number between (1-3)"
    end
  end

  def clear_screen_and_display_board
    clear_screen
    players.each { |x| puts "#{x.class} player #{x.name}: #{x.marker} " }
    alert "First player who matches #{board.n_matches} wins the round"
    alert "First player who scores 3 wins the game"
    puts ""
    board.draw
    puts ""
  end

  def players_move
    players.each do |player|
      player.move(board)
      clear_screen_and_display_board
      break if board.full? || board.someone_won?
    end
  end

  def calculate_scores(winner)
    winner.score += 1
  end

  def winner
    players.find { |player| player.marker == board.winning_marker }
  end

  def score_board
    players.map do |player|
      "#{player.name}'s score: #{player.score}"
    end.join(' | ')
  end

  def calculate_scores_and_display_results
    if board.someone_won?
      calculate_scores(winner)
      display_winning_player(winner)
    else
      alert "The board is full! It's a tie"
    end

    bannerize(score_board, '-')
  end

  def continue?
    loop do
      prompt "Hit Enter to continue, or 'x' to exit..."
      answer = gets.chomp
      break answer.empty? if ['', 'x'].include? answer.downcase
      alert "Sorry, must be Enter or 'x'"
    end
  end

  def display_winning_player(winner)
    bannerize("#{winner.class} player #{winner.name} won this turn!", '.')
  end

  def player_reached_max_score?
    !!final_winner
  end

  def final_winner
    players.find { |player| player.score >= WINNING_SCORE }
  end

  def display_final_winner
    if final_winner.is_a?(Human)
      bannerize "Congratulations, #{final_winner.name}! You have won the game!"
    else
      bannerize "#{final_winner.class} player #{final_winner.name} won the game!"
    end
  end

  def reverse_players_order
    @players = @players.reverse
  end

  def play
    clear_screen
    loop do
      clear_screen_and_display_board
      loop do
        players_move
        break if board.full? || board.someone_won?
      end
      clear_screen_and_display_board
      calculate_scores_and_display_results
      board.reset
      reverse_players_order
      break display_final_winner if player_reached_max_score?
      break unless continue?
    end
    display_goodbye_message
  end
end

#===============================================================
#                              BOARD
#===============================================================
class Board
  INITIAL_MARK = ' '
  attr_reader :size, :squares, :winning_lines

  def initialize(size)
    @size = size
    reset
    @winning_lines = calculate_winning_lines
  end

  def reset
    @squares = [INITIAL_MARK] * (size**2)
  end

  def draw_vertical_lines
    puts "     |" * (size - 1)
  end

  def draw_num_vert_lines(idx)
    ((-size + 1)..0).each do |i|
      if squares[idx + i - 1] == INITIAL_MARK
        print "   #{(idx + i).to_s.rjust(2).blue}"
      else
        print "     "
      end
      i < 0 ? (print "|") : (print "\n")
    end
  end

  def last_square?(idx)
    idx >= (size**2) - 1
  end

  def draw_horizontal_line(idx)
    return if last_square?(idx)
    puts "-----+" * (size - 1) + "-----"
    draw_vertical_lines
  end

  def draw
    draw_vertical_lines
    squares.each_with_index do |square, idx|
      if (idx + 1) % size != 0
        print "  #{square}  |"
      else
        puts "  #{square}"
        draw_num_vert_lines(idx + 1)
        draw_horizontal_line(idx)
      end
    end
  end

  def unmarked_sq_nums(offset = 1)
    squares.map.with_index do |sq, idx|
      sq == INITIAL_MARK ? (idx + offset) : nil
    end.compact
  end

  def unmarked_sq_idx
    unmarked_sq_nums(0)
  end

  def []=(num, marker)
    @squares[num] = marker
  end

  def full?
    unmarked_sq_nums.empty?
  end

  def calculate_win_rows(arr)
    arr.each_slice(size).to_a
  end

  def additional_rows(rows)
    if size == 5
      [[1, 7, 13, 19], [5, 11, 17, 23], [3, 7, 11, 15], [9, 13, 17, 21]]
    elsif size == 9
      (1...5).flat_map do |x|
        [ (x...size).map     { |i| rows[i][i - x]},
          (x...size).map     { |i| rows[i][-i + x - 1]},
          (0...size - x).map { |i| rows[i][i + x]},
          (0...size - x).map { |i| rows[i][-x - 1 - i]} ]
      end
    else
      []
    end
  end

  def calculate_win_diagonals(rows)
    [(0...size).map { |i| rows[i][i] },
     (0...size).map { |i| rows[i][size - 1 - i] }] +
     additional_rows(rows)
  end

  def calculate_win_cols(rows)
    rows.first.zip(*rows[1..-1])
  end

  def calculate_winning_lines
    sq_nums = (0...size**2).to_a
    rows = calculate_win_rows(sq_nums)
    cols = calculate_win_cols(rows)
    diagonals = calculate_win_diagonals(rows)
    rows + cols + diagonals
  end

  def winning_mark(squares, n)
    cons_identical_marks =
      squares.each_cons(n).find do |cons_marks|
        cons_marks.uniq.size == 1 && !cons_marks.include?(INITIAL_MARK)
      end
    cons_identical_marks&.first
  end

  def someone_won?
    !!winning_marker
  end

  def n_matches
    case size
    when 3 then 3
    when 5 then 4
    when 7..9 then 5
    end
  end

  def winning_marker
    winning_lines.each do |line|
      squares_check = @squares.values_at(*line)
      winning_mark = winning_mark(squares_check, n_matches)
      return winning_mark unless winning_mark.nil?
    end
    nil
  end
end

#===============================================================
#                              PLAYER
#===============================================================
class Player
  include Displayable

  @@created_markers = { human: [], computer: [] }
  @@names = ['R2D2', 'Hal', 'Sonny']
  @@marker_list = %w[X O V N]

  attr_reader :name, :marker
  attr_accessor :score

  def initialize
    @score = 0
  end
end

class Human < Player
  def initialize
    super
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

  def prompt_move_message(board)
    if board.size < 9
      prompt "#{name}, choose a square between #{joinor(board.unmarked_sq_nums)}: "
    else
      prompt "#{name}, choose a square number that is marked in blue."
    end
  end

  def move(board)
    prompt_move_message(board)
    square =
      loop do
        n = gets.chomp.to_i
        break n if board.unmarked_sq_nums.include?(n)
        alert "Sorry, that's not a valid choice"
      end
    board[square - 1] = marker
  end
end

class Computer < Player
  def initialize
    super
    @name = @@names.delete(@@names[0..2].sample)
    @marker = @@marker_list.shift
    # get the first remaining marker from list
    @@created_markers[:computer] << @marker
    display_player_created
  end

  def move(board)
    square_idx =
      offence_idx(board, count: 4) ||
      defence_idx(board, count: 4) ||
      offence_idx(board, count: 3) ||
      defence_idx(board, count: 3) ||
      offence_idx(board, count: 2) ||
      defence_idx(board, count: 2) ||
      center_idx(board)            ||
      random_idx(board)
    board[square_idx] = marker
  end

  def random_idx(board)
    board.unmarked_sq_idx.sample
  end

  def center_idx(board)
    center = board.size ** 2 / 2
    center if board.squares[center] == Board::INITIAL_MARK
  end

  def size_3_opportunity?(board, marks)
    ([marker] * (board.n_matches - 1) +
      [Board::INITIAL_MARK]).sort == marks.sort
  end

  def size_n_opportunity?(board, marks, count)
    n_match = board.n_matches
    marks.each_cons(n_match).any? do |cons|
      ([marker] * count +
        [Board::INITIAL_MARK] * (n_match - count)).sort == cons.sort
    end
  end

  def opportunity?(board, marks, count)
    return size_3_opportunity?(board, marks) if board.size == 3
    size_n_opportunity?(board, marks, count)
  end

  def size_3_danger?(board, marks)
    other_markers = marks.sort.drop(1)
    (marks - [Board::INITIAL_MARK]).size == 2 && !marks.include?(marker) &&
    other_markers.uniq.size == 1
  end

  def size_n_danger?(board, marks, count)
    n_match = board.n_matches
    is_danger =
      marks.each_cons(n_match).any? do |cons|
        other_marks = cons.sort.drop(n_match - count)
        !other_marks.include?(marker) &&
        other_marks.uniq.size == 1 &&
        (cons - [Board::INITIAL_MARK]).size == count
    end
  end

  def danger?(board, marks, ct)
    return size_3_danger?(board, marks) if board.size == 3
    size_n_danger?(board, marks, ct)
  end

  def critical_unmarked_idx(board, line_num_marks, count)
    line_num_marks.each_cons(board.n_matches).min_by do |cons|
      cons.flatten.count(Board::INITIAL_MARK)
    end.find { |num, mark| mark == Board::INITIAL_MARK }&.first
  end

  def unmarked_sq_idx(board, line, marks, count)
    if board.size == 3
      return line.find.with_index { |_, i| marks[i] == Board::INITIAL_MARK }
    end

    line_num_marks = marks.map.with_index { |mark, i| [line[i], mark] }

    critical_unmarked_idx(board, line_num_marks, count) ||
    line[marks.index(Board::INITIAL_MARK)]
  end

  def defence_idx(board, opt = {count: 3})
    square_at_offence_risk_idx(board, opt[:count], false)
  end

  def offence_idx(board, opt = {count: 3})
    square_at_offence_risk_idx(board, opt[:count])
  end

  def square_at_offence_risk_idx(board, ct, offence = true)
    board.winning_lines.each do |line|
      marks = board.squares.values_at(*line)
      at_risk =
        offence ? opportunity?(board, marks, ct) : danger?(board, marks, ct)
      if at_risk
        selected_idx = unmarked_sq_idx(board, line, marks, ct)
        next if selected_idx.nil?
        return selected_idx
      end
    end
    nil
  end
end

game = TTTGame.new
game.play