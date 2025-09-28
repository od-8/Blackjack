require_relative "player"
require_relative "deck"

class Blackjack
  attr_accessor :player, :dealer

  def initialize
    @player = Player.new("Player", starting_cards)
    @dealer = starting_cards
  end

  def play_game
    print_logo
    print_info
    game_loop
    # another game
  end

  # Loop that handles playing the game itself
  def game_loop
    loop do
      print_cards

      choice = player_choice

      hit if choice == "hit"
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

  def hit
    player.cards << generate_random_card
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
    player.cards.each_with_index do |card, index|
      case card[0]
      when "D"
        print_card(print_diamonds(card), index)
      when "H"
        print_card(print_hearts(card), index)
      when "C"
        print_card(print_clubs(card), index)
      when "S"
        print_card(print_spades(card), index)
      end
    end
  end

  def print_card(card, index)
    if index == 0
      card.each { |line| puts line }
    else
      print "\e[10A"
      counter = -1

      10.times do
        counter += 1    
        print "\e[0G\e[#{index * 20}C #{card[counter]}\e[E"
      end
    end
  end

  def print_diamonds(card)
    ["+--------------+", "| #{card[1]}            |", '|      /\      |', 
     '|     /  \     |', '|    / /\ \    |', '|    \ \/ /    |', '|     \  /     |',
     '|      \/      |', "|            #{card[1]} |", "+--------------+"]
  end

  def print_hearts(card)
    ["+--------------+", "| #{card[1]}            |", '|    _    _    |',
     '|  (   )(   )  |', '|   \      /   |', '|    \    /    |', '|     \  /     |',
     '|      \/      |', "|            #{card[1]} |", "+--------------+"]
  end

  def print_clubs(card)
    ["+--------------+", "| #{card[1]}            |", '|      __      |', 
     '|    _(  )_    |', '|  _(      )_  |', '| (___    ___) |', '|     \  /     |',
     '|      \/      |', "|            #{card[1]} |", "+--------------+"]
  end

  def print_spades(card)
    ["+--------------+", "| #{card[1]}            |", '|      /\      |', 
     '|     /  \     |', '|    /    \    |', '|   (_/||\_)   |', '|      ||      |', 
     '|      /\      |', "|            #{card[1]} |", "+--------------+"]
  end

  def print_logo
    puts '/$$$$$$$  /$$                      /$$                               /$$'    
    puts '| $$__  $$| $$                    | $$                              | $$'      
    puts '| $$  \ $$| $$  /$$$$$$   /$$$$$$$| $$   /$$ /$$  /$$$$$$   /$$$$$$$| $$   /$$'
    puts '| $$$$$$$ | $$ |____  $$ /$$_____/| $$  /$$/|__/ |____  $$ /$$_____/| $$  /$$/'
    puts '| $$__  $$| $$  /$$$$$$$| $$      | $$$$$$/  /$$  /$$$$$$$| $$      | $$$$$$/ '
    puts '| $$  \ $$| $$ /$$__  $$| $$      | $$_  $$ | $$ /$$__  $$| $$      | $$_  $$ '
    puts '| $$$$$$$/| $$|  $$$$$$$|  $$$$$$$| $$ \  $$| $$|  $$$$$$$|  $$$$$$$| $$ \  $$'
    puts '|_______/ |__/ \_______/ \_______/|__/  \__/| $$ \_______/ \_______/|__/  \__/'
    puts '                                       /$$  | $$'                  
    puts '                                      |  $$$$$$/'                             
    puts '                                       \______/'
  end

  def print_info
    puts ""
    puts "  Welcome to Blackjack!"
    puts "   Here are your cards"
  end
end

game = Blackjack.new
# game.play_game
game.player.cards = ["SA", "D8", "HQ", "CJ"]
game.print_cards
