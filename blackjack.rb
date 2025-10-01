require_relative "display"

class Blackjack
  include Display

  attr_accessor :player_cards, :dealer_cards, :invalid_moves

  def initialize
    @player_cards = starting_cards
    @dealer_cards = starting_cards
    @invalid_moves = 10
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

  # Hangdles playing the game
  def play_game
    print_cards

    if player_go.is_a?(Integer) && dealer_go.is_a?(Integer)
      greatest_total
    end

    new_game if another_game == "yes"
    print_thank_you
  end

  # Handles the player getting cards and if they go bust or have blackjack
  def player_go
    choice = "hit"

    loop do
      choice = player_choice if choice == "hit"
      hit(player_cards) if choice == "hit"

      clear_and_print

      return total(player_cards) if choice == "stand"
      break if blackjack? || bust?
    end
  end

  # Gets the player choice
  def player_choice
    loop do
      @invalid_moves += 3
      print "Player, Hit or Stand: "
      choice = gets.chomp.downcase

      return choice if %w[hit stand].include?(choice)

      puts "Enter Hit or Stand"
      puts ""
    end
  end

  # Adds a random card to the players hand
  def hit(cards)
    cards << generate_random_card
  end

  # Clear the previous full hand and reprints it with the new cards
  def clear_and_print
    print "\e[#{invalid_moves}A\e[J"
    print_cards
    @invalid_moves = 10
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

  def blackjack?
    if is_blackjack?(player_cards) && is_blackjack?(dealer_cards)
      puts "You both have Blackjack. Tie, no winners."
      return true
    elsif is_blackjack?(player_cards)
      puts "You have Blackjack. You win."
      return true
    elsif is_blackjack?(dealer_cards)
      puts "The Dealer has Blackjack. You lose."
      return true
    end

    false
  end

  # Checks if cards are blackjack
  def is_blackjack?(cards)
    return true if total(cards) == 21 && cards.length == 2
      
    false
  end

  def bust?
    if is_bust?(player_cards)
      puts "You went Bust. You lose."
      return true
    elsif is_bust?(dealer_cards)
      puts "The Dealer went bust. You win."
      return true
    end

    false
  end

  def is_bust?(cards)
    return true if total(cards) > 21

    false
  end

  # Handles the dealer getting cards and if they go bust or have blackjack
  def dealer_go
    loop do
      hit(dealer_cards) if total(dealer_cards) < 17

      return total(dealer_cards) if total(dealer_cards) > 16
      break if blackjack? || bust?
    end
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

  def another_game
    loop do
      @invalid_moves += 3
      print "Would you like to play again: "
      choice = gets.chomp.downcase

      return choice if %w[yes no].include?(choice)
      puts "Enter Yes or No"
      puts ""
    end
  end

  def new_game
    @player_cards = starting_cards
    @dealer_cards = starting_cards
    @invalid_moves += 1
    print "\e[#{invalid_moves}A\e[J"
      
    play_game
  end

  def print_thank_you
    puts ""
    puts "Thank you for playing"
    puts ""
  end
end

game = Blackjack.new
game.print_logo
game.play_game