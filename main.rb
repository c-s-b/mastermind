module Colors
  attr_reader :code, :color_list

  @@color_list = %w[blue purple green yellow orange red]
  @@code = []

  def generate_code
    4.times { @@code.push(@@color_list.sample) }
  end
end

class Computer
  include Colors
  def initialize
    @feedback = []
  end

  def evaluate_guess(guess)
    guess.each_with_index do |color, index|
      if @@code.include?(color)
        if @@code.index(color) == index
          @feedback.push('black peg')
        else
          @feedback.push('white peg')
        end
      end
    end
    p @feedback
      p @@code
  end

  def win_or_lose(player)
    if @feedback.count('black peg') == 4
      # display_winner
      return true
    end

    if player.guesses.length == 12
      # display_loser
      return true
    end

    false
  end
end

class Player
  include Colors
  attr_reader :guess, :guesses

  def initialize
    @guess = []
    @guesses = []
  end

  def prompt_guess
    puts 'try to break the code:'
    @guess = gets.chomp.downcase.split(' ')
    until check_guess_contents
      puts 'That guess is not valid. please try again'
      @guess = gets.chomp.downcase.split(' ')
    end
    add_guess
  end

  private

  def add_guess
    @guesses.push(@guess)
  end

  def check_guess_contents
    return false if @guess.empty?

    @guess.all? { |color| @@color_list.include?(color) }
  end
end

class Game
  def initialize
    @computer = Computer.new
    @player = Player.new
    @computer.generate_code
  end

  def run_game
    until @computer.win_or_lose(@player)
      @player.prompt_guess
      @computer.evaluate_guess(@player.guess)
      @computer.win_or_lose(@player)
    end
  end
end

game = Game.new
game.run_game