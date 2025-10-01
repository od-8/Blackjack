module Display
  # Prints dealers face card and players cards
  def print_cards
    print_face_card
    print_player_cards
    puts ""
  end

  # Prints the face card
  def print_face_card
    dealer_card = print_suit(dealer_cards[0])

    puts "Face Card:"
    puts dealer_card

    print_divider
  end

  # Prints a divider between the face card and your cards
  def print_divider
    print "\e[11A" 
    print "\e[0G\e[21C Your Cards:"
    11.times do
      print "\e[0G\e[17C || \n"
    end
  end

  # Prints the players cards
  def print_player_cards
    counter = 0

    player_cards.each_with_index do |card, card_index|
      player_card = print_suit(card)
      counter += 1  

      print "\e[10A"

      player_card.each_with_index do |line, line_index|  
        print "\e[0G\e[#{counter * 21}C #{line} \n"
      end
    end
  end

  # Prints different cards depending on suit
  def print_suit(card)
    case card[0]
    when "D"
      return print_diamonds(card)
    when "H"
      return print_hearts(card)
    when "C"
      return print_clubs(card)
    when "S"
      return print_spades(card)
    end
  end

  # Diamonds card
  def print_diamonds(card)
    ["+--------------+", "| #{card[1]}            |", '|      /\      |', 
     '|     /  \     |', '|    / /\ \    |', '|    \ \/ /    |', '|     \  /     |',
     '|      \/      |', "|            #{card[1]} |", "+--------------+"]
  end

  # Hearts card
  def print_hearts(card)
    ["+--------------+", "| #{card[1]}            |", '|    _    _    |',
     '|  (   )(   )  |', '|   \      /   |', '|    \    /    |', '|     \  /     |',
     '|      \/      |', "|            #{card[1]} |", "+--------------+"]
  end

  # Clubs cards
  def print_clubs(card)
    ["+--------------+", "| #{card[1]}            |", '|      __      |', 
     '|    _(  )_    |', '|  _(      )_  |', '| (___    ___) |', '|     \  /     |',
     '|      \/      |', "|            #{card[1]} |", "+--------------+"]
  end

  # Print spades
  def print_spades(card)
    ["+--------------+", "| #{card[1]}            |", '|      /\      |', 
     '|     /  \     |', '|    /    \    |', '|   (_/||\_)   |', '|      ||      |', 
     '|      /\      |', "|            #{card[1]} |", "+--------------+"]
  end

  # Blackjack logo
  def print_logo
    puts ""
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
    puts ''
  end
end