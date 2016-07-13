class ComputerPlayer

  attr_reader :name

  def initialize
    @name = "computer player"
    @known_cards = {}
    @matched_cards = {}
    @unknown_positions = []
  end

  def get_input(prev_guess, prev_guess_value)
    if prev_guess.nil?
      @known_cards.each do |value, position_list|
        if position_list.length == 2 && !@matched_cards.has_key?(value)
          return position_list[0]
        end
      end
      @unknown_positions.sample
    elsif @known_cards.has_key?(prev_guess_value) &&
      @known_cards[prev_guess_value].length == 2
      guess = @known_cards[prev_guess_value].select {|pos| pos != prev_guess}[0]
    else
      @unknown_positions.sample
    end
  end

  def receive_revealed_card(pos, value)
    if @known_cards[value].nil?
      @known_cards[value] = [pos]
    elsif @known_cards[value].length < 2
      @known_cards[value] << pos
    end
    @unknown_positions.delete(pos)
  end

  def receive_match(pos, other_pos, value)
    @matched_cards[value] = [pos, other_pos]
  end

  def compute_unknown_positions(rows, cols)
    (0...rows).each do |row|
      (0...cols).each do |col|
        @unknown_positions << [row, col]
      end
    end
  end

end
