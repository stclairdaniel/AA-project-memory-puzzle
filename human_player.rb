class HumanPlayer

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_input(prev_guess, prev_guess_value)
    puts "Enter your guess, in the format x,y"
    gets.chomp.split(",").map(&:to_i)
  end

  def receive_revealed_card(pos, value)
  end

  def receive_match(pos, other_pos, value)
  end

  def compute_unknown_positions(rows, cols)
  end

end
