module Colorable # source: Stackoverflow
  def black(str);        "\033[30m#{str}\033[0m" end
  def red(str);          "\033[31m#{str}\033[0m" end
  def green(str);        "\033[32m#{str}\033[0m" end
  def yellow(str);       "\033[33m#{str}\033[0m" end
  def blue(str);         "\033[34m#{str}\033[0m" end
  def magenta(str);      "\033[35m#{str}\033[0m" end
  def cyan(str);         "\033[36m#{str}\033[0m" end
  def gray(str);         "\033[37m#{str}\033[0m" end
end

module Displayable
  include Colorable
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
    puts green(">> #{message}")
  end

  def capitalize_words(str)
    str.split.map(&:capitalize).join(' ')
  end

  def alert(message)
    puts yellow("<!> #{message}...")
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
    sleep 1
    alert "...2"
    sleep 1
    alert "...1"
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
  attr_reader :board, :human, :players, :winning_score

  include Displayable

  def initialize
    display_welcome_message
    choice = prompt_game_mode_choice
    @players = initialize_players(choice)
    @board = initialize_board(choice)
    @winning_score = board.size == 3 ? 5 : 3
    count_down_to_game_start
  end

  def initialize_players(choice)
    case choice
    when 2 then [Human.new, Computer.new, Computer.new]
    when 3 then [Human.new, Human.new, Computer.new]
    when 5 then [Human.new, Computer.new, Computer.new]
    when 6 then [Human.new, Human.new, Computer.new]
    else [Human.new, Computer.new]
    end
  end

  def initialize_board(choice)
    case choice
    when 0 then Board.new(3)
    when 1..3 then Board.new(5)
    when 4..6 then Board.new(9)
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
      puts "  (3) Board: 5x5 | Matches: 4 | Players: Human, Human, Computer"
      puts "  (4) Board: 9x9 | Matches: 5 | Players: Human, Computer"
      puts "  (5) Board: 9x9 | Matches: 5 | Players: Human, Computer, Computer"
      puts "  (6) Board: 9x9 | Matches: 5 | Players: Human, Human, Computer"
      choice = gets.chomp
      break choice.to_i if %w[0 1 2 3 4 5 6].include?(choice) || choice.empty?
      alert "Invalid input, please enter a number between (1-5)"
    end
  end

  def clear_screen_and_display_board
    clear_screen
    players.each { |x| print "#{x.class} player #{x.name}: #{x.marker}. " }
    puts ""
    alert "To win this round: match #{board.n_matches} | " \
    "To win the game: score #{winning_score} rounds"
    puts ""
    board.draw(players)
    puts ""
  end

  def players_move
    players.each do |player|
      player.move(board)
      clear_screen_and_display_board
      break if someone_won_or_game_tie?
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
    players.find { |player| player.score >= winning_score }
  end

  def display_final_winner
    if final_winner.is_a?(Human)
      bannerize "Congratulations, #{final_winner.name}! You have won the game!"
    else
      bannerize "Computer player #{final_winner.name} won the game!"
    end
  end

  def reverse_players_order
    @players = @players.reverse
  end

  def someone_won_or_game_tie?
    board.full? || board.someone_won?
  end

  def play
    clear_screen
    loop do
      clear_screen_and_display_board
      loop do
        players_move
        break if someone_won_or_game_tie?
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
  include Colorable

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

  def print_pipe_or_newline(i)
    i < 0 ? (print "|") : (print "\n")
  end

  def draw_num_vert_lines(idx)
    ((-size + 1)..0).each do |i|
      if squares[idx + i - 1] == INITIAL_MARK
        print "   #{blue((idx + i).to_s.rjust(2))}"
      else
        print "     "
      end
      print_pipe_or_newline(i)
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

  def draw(players)
    draw_vertical_lines
    squares.each_with_index do |square, idx|
      if (idx + 1) % size != 0
        print "  #{colorize(players, square)}  |"
      else
        puts "  #{colorize(players, square)}"
        draw_num_vert_lines(idx + 1)
        draw_horizontal_line(idx)
      end
    end
  end

  def colorize(players, square)
    return INITIAL_MARK if square == INITIAL_MARK
    players.find do |player|
      player.marker == square
    end.color_mark
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

  def size_9_additional_diags
    # (1...5).flat_map do |x|
    #   [(x...size).map     { |i| rows[i][i - x] },
    #    (x...size).map     { |i| rows[i][-i + x - 1] },
    #    (0...size - x).map { |i| rows[i][i + x] },
    #    (0...size - x).map { |i| rows[i][-x - 1 - i] }]
    # end (this will cause rubocop to complain on AbcSize)
    [[9, 19, 29, 39, 49, 59, 69, 79], [17, 25, 33, 41, 49, 57, 65, 73],
     [1, 11, 21, 31, 41, 51, 61, 71], [7, 15, 23, 31, 39, 47, 55, 63],
     [18, 28, 38, 48, 58, 68, 78], [26, 34, 42, 50, 58, 66, 74],
     [2, 12, 22, 32, 42, 52, 62], [6, 14, 22, 30, 38, 46, 54],
     [27, 37, 47, 57, 67, 77], [35, 43, 51, 59, 67, 75],
     [3, 13, 23, 33, 43, 53], [5, 13, 21, 29, 37, 45], [36, 46, 56, 66, 76],
     [44, 52, 60, 68, 76], [4, 14, 24, 34, 44], [4, 12, 20, 28, 36]]
  end

  def additional_diagonals
    return [] if size == 3
    if size == 5
      [[1, 7, 13, 19], [5, 11, 17, 23], [3, 7, 11, 15], [9, 13, 17, 21]]
    elsif size == 9
      size_9_additional_diags
    end
  end

  def calculate_win_diagonals(rows)
    [(0...size).map { |i| rows[i][i] },
     (0...size).map { |i| rows[i][size - 1 - i] }] +
      additional_diagonals
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
    when 9 then 5
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
  @@colors = [:red, :yellow, :magenta]

  attr_reader :name, :marker, :color
  attr_accessor :score

  def initialize
    @score = 0
  end

  def color_mark
    case color
    when :red then red(@marker)
    when :yellow then yellow(@marker)
    when :magenta then magenta(@marker)
    end
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
    @color = @@colors.shift
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
      n = gets.chomp
      return capitalize_words(n) unless invalid_name?(n)
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
      prompt "#{name}, choose a square between " \
             "#{joinor(board.unmarked_sq_nums)}: "
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
  attr_reader :empty_mark

  def initialize
    super
    @empty_mark = Board::INITIAL_MARK
    @color = @@colors.shift
    @name = @@names.delete(@@names[0..2].sample)
    @marker = @@marker_list.shift
    @@created_markers[:computer] << @marker
    display_player_created
  end

  def move(board)
    square_idx =
      offence_defence_idx(board)   ||
      center_idx(board)            ||
      random_idx(board)
    board[square_idx] = marker
  end

  def offence_defence_idx(board)
    offence_idx(board, count: 4)   ||
      defence_idx(board, count: 4) ||
      offence_idx(board, count: 3) ||
      defence_idx(board, count: 3) ||
      offence_idx(board, count: 2) ||
      defence_idx(board, count: 2)
  end

  def random_idx(board)
    board.unmarked_sq_idx.sample
  end

  def center_idx(board)
    center = board.size**2 / 2
    center if board.squares[center] == empty_mark
  end

  def size_3_opportunity?(board, marks)
    ([marker] * (board.n_matches - 1) +
      [empty_mark]).sort == marks.sort
  end

  def size_n_opportunity?(board, marks, count)
    n_match = board.n_matches
    marks.each_cons(n_match).any? do |cons|
      ([marker] * count +
        [empty_mark] * (n_match - count)).sort == cons.sort
    end
  end

  def opportunity?(board, marks, count)
    return size_3_opportunity?(board, marks) if board.size == 3
    size_n_opportunity?(board, marks, count)
  end

  def size_3_danger?(marks)
    (marks - [empty_mark]).size == 2 && !marks.include?(marker)
  end

  def size_n_danger?(board, marks, count)
    n_match = board.n_matches
    marks.each_cons(n_match).any? do |cons|
      other_marks = cons.sort.drop(n_match - count)
      !other_marks.include?(marker) &&
        other_marks.uniq.size == 1 &&
        (cons - [empty_mark]).size == count
    end
  end

  def danger?(board, marks, ct)
    return size_3_danger?(marks) if board.size == 3
    size_n_danger?(board, marks, ct)
  end

  def empty_mark_between_two_other_marks?(line_num_marks)
    line_num_marks.each_cons(3).find do |cons|
      cons[0].last =~ /(?!#{marker})[A-Z]/ &&
        cons[1].last == empty_mark &&
        cons[2].last =~ /(?!#{marker})[A-Z]/
    end
  end

  def empty_mark_next_to_other_mark?(line_num_marks)
    line_num_marks.each_cons(2).find do |cons|
      cons.count { |_, b| b == empty_mark } == 1 &&
        cons.count { |_, b| b =~ /(?!#{marker})[A-Z]/ } == 1
    end
  end

  def critical_unmarked_idx(line, marks)
    line_num_marks = marks.map.with_index { |mark, i| [line[i], mark] }

    selected =
      empty_mark_between_two_other_marks?(line_num_marks) ||
      empty_mark_next_to_other_mark?(line_num_marks)

    selected_arrs = selected&.find { |_, mark| mark == empty_mark }

    selected_arrs&.first || line[marks.index(empty_mark)]
  end

  def unmarked_sq_idx(board, line, marks)
    if board.size == 3
      return line.find.with_index { |_, i| marks[i] == empty_mark }
    end
    critical_unmarked_idx(line, marks)
  end

  def defence_idx(board, opt = { count: 3 })
    square_at_offence_risk_idx(board, opt[:count], false)
  end

  def offence_idx(board, opt = { count: 3 })
    square_at_offence_risk_idx(board, opt[:count])
  end

  def square_at_offence_risk_idx(board, ct, offence = true)
    board.winning_lines.each do |line|
      marks = board.squares.values_at(*line)
      at_risk =
        offence ? opportunity?(board, marks, ct) : danger?(board, marks, ct)
      if at_risk
        selected_idx = unmarked_sq_idx(board, line, marks)
        next if selected_idx.nil?
        return selected_idx
      end
    end
    nil
  end
end

game = TTTGame.new
game.play

