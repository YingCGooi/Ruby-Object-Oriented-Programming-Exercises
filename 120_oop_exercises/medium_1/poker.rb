# In the previous two exercises, you developed a Card class and a Deck class. You are now going to use those classes to create and evaluate poker hands. Create a class, PokerHand, that takes 5 cards from a Deck of Cards and evaluates those cards as a Poker hand.

# You should build your class using the following code skeleton:

# Include Card and Deck classes from the last two exercises.
class Card
  # Enumerable#min and Enumerale#max work with objects whose classes mix-in the Comparable module. The class must provide a #<=> method
  include Comparable
  ORDER = (2..10).to_a + %w[Jack Queen King Ace].freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    ORDER.index(rank)
  end

  def <=>(other_card) # compares them using Integer#<=>
    self.value <=> other_card.value
  end
end

class Deck
  attr_reader :deck
  RANKS = (2..10).to_a + %w[Jack Queen King Ace].freeze
  SUITS = %w[Hearts Clubs Diamonds Spades].freeze

  def initialize
    reset
  end

  def draw
    reset if deck.empty?
    @deck.pop
  end

  private

  def reset # since we need to periodically create a new set of cards, it's easier to do that in a separate method
    @deck = RANKS.product(SUITS).map { |rank, suit| Card.new(rank, suit) }
    @deck.shuffle!
  end
end

class PokerHand
  attr_reader :set

  def initialize(cards)
    @set = cards
  end

  def print
    set.each do |card|
      puts card
    end
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  def values; set.map(&:value) end
  def ranks;  set.map(&:rank)  end
  def suits;  set.map(&:suit)  end

  private

  def include_rank?(rank); ranks.include? rank end
  def same_of_a_kind; ranks.map { |rank| ranks.count(rank) } end
  def max_of_a_kind; same_of_a_kind.max end
  def min_of_a_kind; same_of_a_kind.min end

  def royal_flush?
    straight_flush? && include_rank?('Ace')
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    max_of_a_kind == 4
  end

  def full_house?
    max_of_a_kind == 3 && min_of_a_kind == 2
  end

  def flush?
    suits.uniq.size == 1
  end

  def straight?
    values.sort.each_cons(2).all? { |a, b| b - a == 1 }
  end

  def three_of_a_kind?
    max_of_a_kind == 3
  end

  def two_pair?
    same_of_a_kind.count(2) == 4
  end

  def pair?
    max_of_a_kind == 2
  end
end
# Testing your class:

# hand = PokerHand.new(Deck.new)
# hand.print
# puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
# Output:

# 5 of Clubs
# 7 of Diamonds
# Ace of Hearts
# 7 of Clubs
# 5 of Spades
# Two pair
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true