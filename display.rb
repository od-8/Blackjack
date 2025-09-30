module Display
  # Prints dealers face card and players cards
  def print_cards
    dealer_card = print_suit(dealer.cards[0])
    puts ""
    puts "Face Card:"
    puts dealer_card
    print_spacer
  
    counter = 0

    player.cards.each_with_index do |card, card_index|
      player_card = print_suit(card)
      print "\e[10A"  
      counter += 1  

      player_card.each_with_index do |line, line_index|  
        # print "\e[0G\e[#{card_index * 20}C #{line}\e[E \n"
        print "\e[0G\e[#{counter * 21}C #{line} \n"
      end
    end

    puts ""
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

  def print_spacer
    print "\e[11A" 
    print "\e[0G\e[21C Your Cards:"
    11.times do
      print "\e[0G\e[17C || \n"
    end
  end

  # # Prints the players cards inline
  # def print_player_card(card)
  #   print "\e[10A"
  #   counter = -1

  #   10.times do
  #     counter += 1    
  #     print "\e[0G\e[#{index * 20}C #{card[counter]}\e[E"
  #   end
  # end

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
end