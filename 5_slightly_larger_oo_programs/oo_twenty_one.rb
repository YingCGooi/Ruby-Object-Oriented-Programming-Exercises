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
    horizon_bar(style)
    p_center(message)
    horizon_bar(style)
  end

  def alert(message); puts yellow("<!> #{message}...") end
  def prompt(message); puts green(">> #{message}")     end
  def horizon_bar(style = '-'); puts style * CONSOLE_WIDTH  end

  def p_center(message)
    return puts message.center(CONSOLE_WIDTH + 17) if message.include?("[0m")
    puts message.center(CONSOLE_WIDTH)
  end

  def prompt_enter
    prompt "Hit Enter to continue..."
    gets
  end

  def display_welcome_message
    bannerize "Welcome to TwentyOne!"
    alert "Dealing cards"
    prompt_enter
  end

  def clear_screen
    system('clear') || system('cls')
  end
end

class TwentyOne
  include Displayable

  def initialize
    @deck = Deck.new
    @players = [Human.new(@deck), Human.new(@deck), Computer.new(@deck)]
    @dealer = @players.last
  end

  def play
    display_welcome_message
    players_turn
    show_result
  end

  private

  def win_or_busted(player)
    unless player.eql?(@dealer)
      if player.total_value > 21
        " - BUSTED!"
      elsif player.total_value > @dealer.total_value || @dealer.bust?
        " - WIN!"
      else
        " - LOST!"
      end
    else
      if  @dealer.bust?
        " - BUSTED!"
      elsif @players.map { |player| player.total_value }.max == player.total_value
        " - WIN!"
      end
    end
  end

  def show_result
    clear_screen
    @players.each { |player| player.show_hand }
    result =
      @players.map do |player|
        "#{player.name}: #{player.total_value} #{win_or_busted(player)}"
      end
    bannerize(result.join(' | '), '-')
  end

  def other_players_reveal_one_card(current_player)
    @players.each do |player|
      puts_first_card_only(player) if player != current_player
    end
  end

  def puts_first_card_only(player)
    p_center "#{player.name} has #{player.hand.first} #{unknown_cards}"
  end

  def unknown_cards
  end

  def players_turn
    @players.each do |current_player|

      loop do
        clear_screen
        current_player.show_hand if current_player.is_a?(Human)
        puts "-" * CONSOLE_WIDTH
        other_players_reveal_one_card(current_player)

        if !current_player.keep_hitting?(@deck) || current_player.bust?
          break
        end
      end

    end
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

  def value; Deck::RANKS.index(rank) end

end

#============================================================================
#                                  Players
#============================================================================
class Player
  MAX_VALUE = 21

  include Displayable

  attr_reader :hand, :name, :total_value

  def initialize(deck)
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

    # compensate for Aces
    values.count('A').times { sum -= 10 if sum > MAX_VALUE }

    sum
  end

  def bust?
    total_value > 21
  end

  def show_hand
    p_center "#{name}, you have:"
    hand.each { |card| puts card }
    # p_center "#{hand.map(&:to_s).join(' ')}"
    p_center "#{name}, you have total value of #{total_value} on hand"
  end
end

class Human < Player
  def initialize(deck)
    super
    @name = prompt_name
  end

  def prompt_name
    loop do
      prompt "Enter your name: "
      answer = gets.chomp
      break answer if !answer.empty?
      alert "Sorry...must enter a name"
    end
  end

  def keep_hitting?(deck)
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
  ROBOTS = %w[R2D2 Hal Sonny]

  def initialize(deck)
    super
    @name = ROBOTS.sample
  end

  def keep_hitting?(deck)
    hit(deck) until total_value >= 17
  end
end

TwentyOne.new.play
