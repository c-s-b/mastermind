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
  attr_reader :guesses

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

c = Code.new
p c.code
g = GuessList.new
g.prompt_guess
p g.guesses