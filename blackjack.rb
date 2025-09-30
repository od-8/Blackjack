require_relative "player"
require_relative "dealer"
require_relative "display"

class Blackjack
  include Display

  attr_accessor :player, :dealer

  def initialize
    @player = Player.new("Player", starting_cards)
    dealer_cards = starting_cards
    @dealer = Dealer.new(dealer_cards, dealer_cards[0])
  end

  def play_game
    print_logo
    print_cards
    # print_info
    result = game_loop
    
    winner if result == "stand"
    # another game
  end

  # Loop that handles playing the game itself
  def game_loop
    choice = "hit"

    loop do
      choice = player_choice if choice == "hit"

      hit(player) if choice == "hit"
      print "\e[14A\e[J"
      print_cards

      break if game_over?

      hit(dealer) if total(dealer) < 17

      break if game_over?

      return "stand" if (total(dealer) > 17 && choice == "stand")
    end
  end

  def winner
    if total(player) > total(dealer)
      puts "Player Wins!"
    elsif total(player) < total(dealer)
      puts "Dealer Wins!"
    else
      puts "Its a tie"
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

  def hit(person)
    person.cards << generate_random_card
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
  def total(person)
    total = 0

    person.cards.each do |card|
      total += 10 if %w[J Q K].include?(card[1])
    
      total += card[1].to_i if card[1].to_i.is_a?(Integer)

      total += 1 if card[1] == "A"
    end

    total += 10 if ((total + 10) < 22) && person.cards.any? { |card| card[1] == "A" }

    return total
  end

  def dealer_win
    puts "The dealer won"
  end

  def player_win
    puts "The player won"
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

  def has_blackjack?(person)
    return true if total(person) == 21 && person.cards.length == 21
      
    false
  end

  def game_over?
    return true if blackjack?
    return true if is_bust?
  end

  def blackjack?
    if has_blackjack?(player) && has_blackjack?(dealer)
      puts "You both have blackjack draw"
      return true
    elsif has_blackjack?(player) 
      puts "Player wins with blackjack"
      return true
    elsif has_blackjack?(dealer)
      puts "Dealer wins with blackjack"
      return true
    end

    return false
  end

  def is_bust?
    if total(player) > 21
      puts "Player is bust"
      return true
    elsif total(dealer) > 21
      puts "Dealer is bust"
      return true
    end

    false
  end
end

game = Blackjack.new
game.play_game
# game.player.cards = ["SA", "D8", "HQ", "CJ"]
# game.print_cards

# if both stand and even its a draw