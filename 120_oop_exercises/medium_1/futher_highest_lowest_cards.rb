class Card
  # Enumerable#min and Enumerale#max work with objects whose classes mix-in the Comparable module. The class must provide a #<=> method
  include Comparable
  ORDER = (2..10).to_a + ['Jack', 'Queen', 'King', 'Ace']
  SUIT_ORDER = ['Diamonds', 'Clubs', 'Hearts', 'Spades']

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def rank_value
    ORDER.index(rank)
  end

  def suit_value
    SUIT_ORDER.index(suit)
  end

  def <=>(other_card) # compares them using Integer#<=>
    if self.rank_value == other_card.rank_value
      self.suit_value <=> other_card.suit_value
    else
      self.rank_value <=> other_card.rank_value
    end
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(2, 'Spades'),
         Card.new(2, 'Diamonds'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs'),
         Card.new('Ace', 'Spades')]
p cards
puts cards # 2 of Hearts, 10 of Diamonds, Ace of Clubs
puts
puts cards.min #== Card.new(2, 'Hearts')
puts cards.max #== Card.new('Ace', 'Clubs')
puts
puts cards.sort