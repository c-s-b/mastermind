class Colors
  def initialize
    @color_list = %w[blue purple green yellow orange red]
  end
end

class Code < Colors
  attr_reader :code

  def initialize
    super
    @code = @color_list.sample(4)
  end
end

class GuessList < Colors
  attr_reader :guesses, :guess

  def initialize
    super
    @guesses = []
    @guess = []
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

    @guess.all? { |color| @color_list.include?(color) }
  end
end

class Computer
  def evaluate_guess (code, guess)
    @feedback = []
    guess.each_with_index do |color, index|
      if code.include?(color)
        if code.index(color) == index
          @feedback.push('black peg')
        else
          @feedback.push('white peg')
        end
      end
    end
    puts @feedback
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

c = Code.new
g = GuessList.new
pc = Computer.new
g.prompt_guess
pc.evaluate_guess(c.code, g.guess)
p c.code
p pc.win_or_lose(g)