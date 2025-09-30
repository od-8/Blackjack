class Dealer
  attr_accessor :cards, :upcard

  def initialize(cards, upcard)
    @cards = cards
    @upcard = upcard
  end
end