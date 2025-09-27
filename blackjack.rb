require_relative "player"
require_relative "deck"

class Blackjack
  attr_accessor :player, :dealer

  def initialize
    @player = Player.new("Player", starting_cards)
    @dealer = starting_cards
  end

  # Loop that handles playing the game itself
  def game_loop
    # print_cards

    # if player_choice == "hit"
    #   player.cards << generate_random_card
    # end
    # puts "You get a card"
    # puts "dealer gets a card"

    # dealer.hand << generate_random_card
  end

  # Creates the starting hand which contains 2 cards
  def starting_cards
    cards = []
    
    2.times do
      cards << generate_random_card
    end

    return cards
  end

  # Generates a random card from a random suit
  def generate_random_card
    arr = [1, 2, 3, 4 ,5, 6, 7, 8, 9, "J", "Q", "K", "A"]

    suit = convert_to_suit(rand(1..4))
    card = arr[rand(0..12)]

    return suit + card.to_s
  end

  # Converts a radnom number to a suit
  def convert_to_suit(num)
    case num
    when 1
      return "D"
    when 2
      return "H"
    when 3
      return "C"
    when 4
      return "S"
    end
  end

  # Gets the players total
  def caculate_total(cards)
    total = 0

    cards.each do |card|
      total += 10 if %w[J Q K].include?(card[1])
    
      total += card[1].to_i if card[1].to_i.is_a?(Integer)

      total += 1 if card[1] == "A"
    end

    total += 10 if (total + 10) < 22

    return total
  end

  def has_blackjack?(cards)
    return true if caculate_total(cards) == 21 && cards.length == 2

    false
  end

  def has_21(cards)
    return true if caculate_total(cards) == 21

    false
  end

  def is_bust?(cards)
    return true if caculate_total(cards) < 21

    false
  end

  # Gets the player choice
  def player_choice
    loop do
      print "#{player.name}, Hit or Stand: "
      choice = gets.chomp.downcase

      return choice if %w[hit stand].include?(choice)

      puts "Enter either Hit or Stand"
      puts ""
    end
  end

  def print_cards
    p player.cards
  end
end

# game = Blackjack.new
# game.game_loop