# Architecture
=begin

Human
  @name
  @score
  move

Computer < Human
  move


Round(Human, Human)
  @winner
  start

Game
  @Humans
  @number_of_rounds
  start

=end



class Player
  attr_accessor :score, :hand
  HANDS = { "p" => "paper", "r" => "rock", "s" => "scissors"}

  def initialize
    @score = 0
  end

  def win
    self.score += 1
  end
end


class Human < Player
  attr_accessor :name

  def initialize
    puts "Hello, what is your name?"
    @name = gets.chomp
    super
  end

  def pick_hand
    puts "#{name}, pick your hand: (P/R/S)"
    choice = gets.chomp.downcase
    if %w{p r s}.include?(choice)
      puts "#{name} picked #{HANDS[choice]}"
      @hand = choice
    else
      puts "Invalid choice. Try again. "
      pick_hand
    end
  end
end

class Computer < Player
  def pick_hand
    choice = %w{p r s}.sample
    puts "Computer picked #{HANDS[choice]}"
    @hand = choice
  end
end

class Game
  attr_accessor :human, :computer, :num_of_rounds

  def initialize
    @human = Human.new
    @computer = Computer.new
    @num_of_rounds = 0
  end

  def new_round
    system 'clear'
    @num_of_rounds += 1
    puts ">> Round #{num_of_rounds}"
    human.pick_hand
    computer.pick_hand
    compare(human.hand, computer.hand)
    show_scores
    start_new_round_or_quit
  end

  def compare(hand1, hand2)
    if hand1 == hand2
      puts "It's a draw!"
    elsif (hand1 == 'p' && hand2 == 'r') || (hand1 == 's' && hand2 == 'p') || (hand1 == 'r' && hand2 == 's')
      puts "#{human.name} won!"
      human.win
    else
      puts "#{human.name} lose..."
      computer.win
    end
  end

  def show_scores
    puts "-------------------------------------------"
    puts "#{human.name}'s score is: #{human.score}."
    puts "Computer's score is: #{computer.score}"
    puts "-------------------------------------------"
  end

  def start_new_round_or_quit
    puts "Play again? (Y/N)"
    choice = gets.chomp.downcase
    start_new_round_or_quit unless %w{y n}.include?(choice)
    return new_round if choice == 'y'
    puts "#{human.name}, see you next time!" if choice == 'n'
  end
end

Game.new.new_round
