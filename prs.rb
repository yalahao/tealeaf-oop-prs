# Architecture
=begin

Player
  @name
  @score
  move

Computer < Player
  move


Round(player, player)
  @winner
  start

Game
  @players
  @number_of_rounds
  start

=end

MOVES = { "p" => "paper", "r" => "rock", "s" => "scissors"}

module Winnable
  def win
    self.score += 1
  end
end


class Player
  attr_accessor :name, :score
  include Winnable

  def initialize
    puts "Hello, what is your name?"
    @name = gets.chomp
    @score = 0
  end

  def move
    puts "Choose your play: (P/R/S)"
    choice = gets.chomp.downcase
    if %w{p r s}.include?(choice)
      puts "#{name} chose #{MOVES[choice]}"
      return choice
    else
      puts "Invalid choice. Try again. "
      move
    end
  end
end

class Computer
  attr_accessor :score
  include Winnable

  def initialize
    @score = 0
  end

  def move
    choice = %w{p r s}.sample
    puts "Computer chose #{MOVES[choice]}"
    return choice
  end
end

class Game
  attr_accessor :player, :computer, :num_of_rounds

  def initialize
    @player = Player.new
    @computer = Computer.new
    @num_of_rounds = 0
  end

  def new_round
    system 'clear'
    @num_of_rounds += 1
    puts ">> Round #{num_of_rounds}"
    check_winner(player.move, computer.move )
    show_scores
    start_new_round_or_quit
  end

  def check_winner(choice1, choice2)
    win = "#{player.name} won!"
    lose = "#{player.name} lose..."
    paper = "Paper wraps rock."
    scissors = "Scissors cut paper."
    rock = "Rock breaks scissors."

    if choice1 == choice2
      puts "It's a draw!"
    elsif (choice1 == 'p' && choice2 == 'r')
      puts "#{paper} #{win}"
      player.win
    elsif (choice1 == 'r' && choice2 == 'p')
      puts "#{paper} #{lose}"
      computer.win
    elsif (choice1 == 'p' && choice2 == 's')
      puts "#{scissors} #{lose}"
      computer.win
    elsif (choice1 == 's' && choice2 == 'p')
      puts "#{scissors} #{win}"
      player.win
    elsif (choice1 == 'r' && choice2 == 's')
      puts "#{rock} #{win}"
      player.win
    elsif (choice1 == 's' && choice2 == 'r')
      puts "#{rock} #{lose}"
      computer.win
    else
      say "Something went wrong. Restart the game and make sure you choose the valid options."
    end
  end

  def show_scores
    puts "-------------------------------------------"
    puts "#{player.name}'s score is: #{player.score}."
    puts "Computer's score is: #{computer.score}"
    puts "-------------------------------------------"
  end

  def start_new_round_or_quit
    puts "Play again? (Y/N)"
    choice = gets.chomp.downcase
    start_new_round_or_quit unless %w{y n}.include?(choice)
    return new_round if choice == 'y'
    puts "Till next time!" if choice == 'n'
  end
end

Game.new.new_round
