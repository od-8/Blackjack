require_relative "display"

class Blackjack
  include Display

  attr_accessor :player_cards, :dealer_cards

  def initialize
    @player_cards = starting_cards
    @dealer_cards = starting_cards
    @invalid_moves = 10
  end

  # Hangdles playing the game
  def play_game
    print_logo
    print_cards
    game_loop
  end

  # Loop that handles playing the game itself
  def game_loop
    choice = "hit"

    loop do
      break if game_over?

      choice = player_choice if choice == "hit"
      hit(player_cards) if choice == "hit"

      # clear_and_print

      break if game_over?

      hit(dealer_cards) if total(dealer_cards) < 17

      if (total(dealer_cards) > 16 && choice == "stand")
        greatest_total
        break
      end
    end
  end

  def clear_and_print
    print "\e[14A\e[J"
    print_cards
  end

  # Winner is the person with the greatest total
  def greatest_total
    player_total = total(player_cards)
    dealer_total = total(dealer_cards)

    if player_total > dealer_total
      puts "You win! The dealer had a total of #{dealer_total}."
    elsif player_total < dealer_total
      puts "House always wins. The dealer had a total of #{dealer_total}."
    else
      puts "Its a tie, no winners."
    end
  end

  # Creates the starting hand which contains 2 cards
  def starting_cards
    cards = []
    
    2.times do
      cards << generate_random_card
    end

    return cards
  end

  def hit(cards)
    cards << generate_random_card
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
  def total(cards)
    total = 0

    cards.each do |card|
      total += 10 if %w[J Q K].include?(card[1])
      total += card[1].to_i if card[1].to_i.is_a?(Integer)
      total += 1 if card[1] == "A"
    end

    total += 10 if ((total + 10) < 22) && cards.any? { |card| card[1] == "A" }

    return total
  end

  # Gets the player choice
  def player_choice
    loop do
      print "Player, Hit or Stand: "
      choice = gets.chomp.downcase

      return choice if %w[hit stand].include?(choice)

      puts "Enter either Hit or Stand"
      puts ""
    end
  end

  # When player goes bust or has blackjack
  def game_over?
    return true if blackjack?
    return true if is_bust?
  end

  # Print statement for when either dealer or player has blackjack
  def blackjack?
    player_blackjack = has_blackjack?(player_cards)
    dealer_blackjack = has_blackjack?(dealer_cards)

    if player_blackjack == true && dealer_blackjack == true
      puts "You both have blackjack. Its a tie."
      return true
    elsif player_blackjack == true
      puts "Congratulations. You win with blackjack!"
      return true
    elsif dealer_blackjack == true
      puts "House always win. Dealer wins with blackjack."
      return true
    end

    return false
  end

  # Checks if cards are blackjack
  def has_blackjack?(cards)
    return true if total(cards) == 21 && cards.length == 2
      
    false
  end

  # When either the dealer or the player goes bust
  def is_bust?
    if total(player_cards) > 21
      puts "You lose. You went bust!"
      return true
    elsif total(dealer_cards) > 21
      puts "You win. The dealer went bust!"
      return true
    end

    false
  end
end

game = Blackjack.new
game.play_game