# data structure - use hashes 52 cards, 4 suits, 2 colours
# set player 1
# set dealer
# set player 1 score variable
# set dealer score variable
# deal player 1 two cards
# deal dealer two cards
# calculate score for player 1 - factor in aces
# calculate score for dealer - factor in aces
# ask player 1 to hit or stay
# if play then deal another card
# check score, if ace then ask if worth 1 or 11
# ask if hit or play
# if dealer < 17 then give new card
# check dealer score
# ask dealer if hit or stay
# check who has the highest score

def calculate_total(cards) # ['h', '3'] etc
  arr = cards.map {|e| e[1]}

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0  # J, Q, K
      total += 10
    else
      total += value.to_i
    end
  end

  # correct for aces
  arr.select{|e| e == "A"}.count.times do
    total -= 10 if total > 21   
  end

  total
end

# start game

puts "Thanks for playing Blackjack, please enter your name"
name = gets.chomp
puts "Welcome #{name}, you will be playing against the dealer, good luck"

suits = ['H', "D", "C", "S"]
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
deck = suits.product(cards)
deck.shuffle!



player_1_cards = []
dealer_cards = []

# deal cards

player_1_cards << deck.pop
dealer_cards << deck.pop
player_1_cards << deck.pop
dealer_cards << deck.pop

player_1_total = calculate_total(player_1_cards)
dealer_total = calculate_total(dealer_cards)

# show cards

puts "player has #{player_1_cards[0]} & #{player_1_cards[1]}, for a total of #{player_1_total}"
puts "dealer has #{dealer_cards[0]} & #{dealer_cards[1]}, for a total of #{dealer_total}"
puts " "

#player turn 
if player_1_total == 21
  puts "Congratulations, you hit Blackjack, YOU WIN"
  exit
end
while player_1_total < 21
  puts "What would you like to do? 1)for hit, 2) for stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "Error, you must enter 1 or 2"
    next
  end

  if hit_or_stay == '2'
    puts "You chose to stay"
    break
  end

  #hit
  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  player_1_cards << new_card
  player_1_total = calculate_total(player_1_cards)
  puts "Your total is now #{player_1_total}"

  if player_1_total == 21
    puts "Congratulations, you hit blackjack, YOU WIN"
    exit
  elsif player_1_total > 21
    puts "Sorry, it looks like you busted"
    exit
  end
end

#dealer turn
  if dealer_total == 21
    puts "Sorry, dealer hits blackjack, YOU LOSE."
    exit
  end

while dealer_total < 17
  new_card = deck.pop
  puts "Dealing new card for dealer: #{new_card}"
  dealer_cards << new_card
  dealer_total = calculate_total(dealer_cards)
  puts "Dealer total is now: #{dealer_total}"

  if dealer_total == 21
    puts "Sorry dealer hit jackblack. You lose."
    exit
  elsif dealer_total > 21
    puts "Congratulation, dealer busted.  YOU WIN!"
    exit
  end
end

#compare hands

puts "Dealers cards: "
dealer_cards.each do |card|
  puts "=> #{card}" 
end
puts " "

puts "Your cards:"
player_1_cards.each do |card|
  puts "=> #{card}"
end

if dealer_total > player_1_total
  puts "Sorry, dealer won"
elsif dealer_total < player_1_total
  puts "Congratulations, you win"
else
  puts "It's a tie"
end

exit
