module Colorable
  def black(str);        "\033[30m#{str}\033[0m" end
  def red(str);          "\033[31m#{str}\033[0m" end
  def green(str);        "\033[32m#{str}\033[0m" end
  def yellow(str);       "\033[33m#{str}\033[0m" end
  def blue(str);         "\033[34m#{str}\033[0m" end
  def magenta(str);      "\033[35m#{str}\033[0m" end
  def cyan(str);         "\033[36m#{str}\033[0m" end
  def gray(str);         "\033[37m#{str}\033[0m" end
  def bg_gray(str);      "\e[47m#{str}\e[0m"     end
end

module Displayable
  include Colorable

  CONSOLE_WIDTH = 80

  def bannerize(message, style = '=')
    p_horizon_bar(style)
    p_center(message)
    p_horizon_bar(style)
  end

  def clear_screen; system('clear') || system('cls') end

  def display_welcome_message
    bannerize "Welcome to TwentyOne!"
  end

  def prompt_enter
    prompt "Hit Enter to continue..."
    gets
  end

  def alert(message)
    puts yellow("<!> #{message}...")
  end

  def prompt(message)
    puts green(">> #{message}")
  end

  def p_horizon_bar(style = '-')
    puts style * CONSOLE_WIDTH
  end

  def capitalize_words(str)
    str.split.map(&:capitalize).join(' ')
  end

  def p_short_line
    puts(("-" * (CONSOLE_WIDTH / 2)).center(CONSOLE_WIDTH))
  end

  def offset(message)
    9 * message.scan(/\[0m/).count
  end

  def p_center(message)
    puts message.center(CONSOLE_WIDTH + offset(message))
  end

  def print_rjust(message)
    print(message.rjust(CONSOLE_WIDTH / 2 - 1 + offset(message)))
  end

  def display_goodbye_message
    bannerize "Thank you for playing 21! Goodbye!"
  end

  def print_title_summary_of_scores
    p_horizon_bar("=")
    p_center "Summary of scores"
    p_short_line
  end
end

class TwentyOne
  include Displayable

  def initialize
    display_welcome_message
    @deck = Deck.new
    @players = initialize_players
    @dealer = @players.last
  end

  def play
    loop do
      players_turn
      show_result
      reset
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  def reset
    @deck = Deck.new
    @players.each { |player| player.reset_hand(@deck) }
  end

  def play_again?
    answer =
      loop do
        prompt "Play again? (y/n)"
        answer = gets.chomp
        break answer.downcase if %w[y n].include? answer.downcase
        alert "Sorry...must be (y/n)"
      end
    answer == 'y'
  end

  def prompt_num_players
    loop do
      prompt "Please choose the number of players (2-8)." \
      " Leave empty for default (2):"
      answer = gets.chomp
      break answer.to_i if (2..8).cover? answer.to_i
      break 2 if answer.empty?
      alert "Invalid input. Try again"
    end
  end

  def prompt_dealer_type
    loop do
      prompt "(C)omputer or (h)uman as dealer?" \
      " Leave empty for default (computer):"
      answer = gets.chomp
      break Human if answer.downcase == 'h'
      break Computer if answer.downcase == 'c' || answer.empty?
      alert "Invalid input. Try again"
    end
  end

  def initialize_players
    num_players = prompt_num_players
    dealer_type = prompt_dealer_type

    (1...num_players).map { Human.new(@deck) } +
      [dealer_type.new(@deck, dealer: true)]
  end

  def players_turn
    @players.each_with_index do |current_player, idx|
      loop do
        clear_screen
        p_center(current_and_next_turn_player_name(idx))
        puts
        other_players_reveal_one_card(current_player)

        p_horizon_bar
        current_player.show_hand if current_player.is_a?(Human)

        break if !current_player.keep_hitting?(@deck)
      end
    end
  end

  def show_result
    clear_screen

    (@players - [@dealer]).each_with_index do |player, idx|
      p_horizon_bar if idx > 0
      player.show_hand
    end

    show_dealer_hand_or_not

    print_title_summary_of_scores

    (@players - [@dealer]).each do |player|
      print_rjust "#{player.name}: " \
      "#{player.total_value}"
      puts " #{win_or_busted(player)}"
    end

    show_dealer_total_or_not
  end

  def show_dealer_hand_or_not
    p_horizon_bar
    @dealer.show_hand if !@dealer.bust? && !all_other_players_busted?
  end

  def show_dealer_total_or_not
    print_rjust "#{dealer_or_not(@dealer)} #{@dealer.name}"

    if @dealer.bust?
      puts red(" - BUSTED!")
    elsif all_other_players_busted?
      puts green(" - WIN!")
    else
      puts ": #{@dealer.total_value}"
    end
  end

  def all_other_players_busted?
    (@players - [@dealer]).all?(&:bust?)
  end

  def win_or_busted(player)
    if player.bust?
      red(" - BUSTED!")
    elsif player.total_value > @dealer.total_value || @dealer.bust?
      green(" - WIN!")
    elsif player.total_value < @dealer.total_value
      red(" - LOST!")
    else
      blue(" - TIE!")
    end
  end

  def other_players_reveal_one_card(current_player)
    @players.each do |player|
      show_first_card_only(player) if player != current_player
    end
  end

  def show_first_card_only(player)
    print_rjust "#{dealer_or_not(player)}#{player.name} has:"
    puts " #{player.hand.first}#{unknown_cards(player)}"
    puts
  end

  def unknown_cards(player)
    " #{bg_gray(black('[?]'))}" * (player.hand.count - 1)
  end

  def dealer_or_not(player)
    yellow("DEALER => ") if player.eql?(@dealer)
  end

  def display_next_player_name(idx)
    "| Next player: #{@players[idx + 1].name}" if idx < @players.size - 1
  end

  def current_and_next_turn_player_name(idx)
    " #{@players[idx].name}'s turn #{display_next_player_name(idx)}"
  end
end

class Deck
  RANKS = (2..10).to_a + %w[J Q K A].freeze
  SUITS = %w[Hearts Clubs Diamonds Spades].freeze

  def initialize; reset end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map { |rank, suit| Card.new(rank, suit) }
    @deck.shuffle!
  end
end

class Card
  include Colorable

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def custom_suit
    case suit
    when "Spades"   then "\u{2660}"
    when "Hearts"   then "\u{2665}"
    when "Diamonds" then "\u{2666}"
    when "Clubs"    then "\u{2663}"
    end
  end

  def to_s
    case suit
    when 'Clubs', 'Spades' then black(bg_gray("#{rank} #{custom_suit}"))
    when 'Hearts', 'Diamonds'then red(bg_gray("#{rank} #{custom_suit}"))
    end
  end
end

class Player
  MAX_VALUE = 21

  include Displayable

  attr_reader :hand, :name, :total_value

  def initialize(deck, opt)
    @is_dealer = opt[:dealer]
    reset_hand(deck)
  end

  def reset_hand(deck)
    @hand = []
    2.times { hit(deck) }
  end

  def hit(deck)
    hand << deck.draw
  end

  def total_value
    sum = 0
    values = hand.map(&:rank)
    values.each do |value|
      sum += if    value == 'A'    then 11
             elsif value.to_i == 0 then 10
             else  value.to_i
             end
    end

    values.count('A').times { sum -= 10 if sum > MAX_VALUE }

    sum
  end

  def bust?
    total_value > 21
  end

  def dealer?
    @is_dealer
  end

  def show_hand
    print_rjust "#{name}'s hand: "
    puts hand.map(&:to_s).join(' ').to_s
    p_center "#{name}, you have total value of #{total_value} on hand"
  end
end

class Human < Player
  @@names = []

  def initialize(deck, opt = { dealer: false })
    super
    @name = prompt_name
    @@names << @name
  end

  def invalid_name?(n)
    n.empty? || !n[/[a-z]/i] || same_existing_name?(n)
  end

  def same_existing_name?(n)
    @@names.include?(capitalize_words(n))
  end

  def player_number_or_dealer
    return "Dealer" if dealer?
    "Player ##{@@names.count + 1}"
  end

  def prompt_name
    loop do
      prompt "#{player_number_or_dealer}, please enter your name: "
      n = gets.chomp
      break capitalize_words(n) unless invalid_name?(n)
      next alert "Cannot be the same name" if same_existing_name?(n)
      alert "Sorry...name cannot be empty and must contain a letter"
    end
  end

  def keep_hitting?(deck)
    if bust?
      alert "You are busted"
      prompt_enter
      return false
    end

    answer =
      loop do
        prompt "Enter to hit, 's' to stay..."
        a = gets.chomp
        break a.downcase if a.empty? || a.downcase == 's'
        alert "Invalid input"
      end
    hit(deck) if answer.empty?
  end
end

class Computer < Player
  def initialize(deck, opt = { dealer: true })
    super
    @name = "A.I."
  end

  def keep_hitting?(deck)
    hit(deck) until total_value >= 17
  end
end

TwentyOne.new.play
