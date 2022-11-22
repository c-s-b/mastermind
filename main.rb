module Colors
  attr_reader :color_list

  @@color_list = %w[blue purple green yellow orange red]
end

class Computer
  attr_reader :code, :feedback

  include Colors
  def initialize
    @code = []
    @feedback = []
  end

  def evaluate_guess(guess)
    code_copy = @code.dup
    guess.each_with_index do |color, index|
      if @code.at(index) == color
        @feedback.push('black peg')
        guess[index], code_copy[index] = nil
      end
    end
    guess.intersection(code_copy).compact.each do |color|
      [guess.count(color), code_copy.count(color)].min.times { @feedback.push('white peg') }
    end
  end

  def win_or_lose(player)
    if @feedback.count('black peg') == 4
      Game.display_winner
      return true
    end
    if player.guesses.length == 12
      Game.display_loser
      return true
    end
    @feedback = []
    false
  end

  def generate_code
    4.times { @code.push(@@color_list.sample) }
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
      puts @computer.feedback.to_s
      @computer.win_or_lose(@player)
    end
  end

  def self.display_winner
    puts 'you win!'
  end

  def self.dispay_loser
    puts 'you lose'
  end
end

game = Game.new
game.run_game