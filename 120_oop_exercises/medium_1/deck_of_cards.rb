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

p deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
