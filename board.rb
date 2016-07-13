require_relative 'card'

class Board

  attr_reader :grid, :num_rows, :num_cols

  def initialize(n, m)
    @grid = Array.new(n) {Array.new(m)}
    @num_rows = n
    @num_cols = m
  end

  def self.valid?(n, m)
    (n * m) % 2 == 0
  end

  def populate
    num_pairs = (@num_rows * @num_cols) / 2
    pair_values = ('a'..'z').to_a.sample(num_pairs)
    card_values = (pair_values * 2).shuffle
    cards = []
    card_values.each do |value|
      cards << Card.new(value)
    end

    (0...@num_rows).each do |row|
      (0...@num_cols).each do |col|
        @grid[row][col] = cards.pop
      end
    end
  end

  def render
    (0...@num_rows).each do |row|
      row_values = []
      (0...@num_cols).each do |col|
        row_values << @grid[row][col].display
      end
      puts row_values.join("|")
      puts "-" * (2 * @num_cols - 1)
    end
  end

  def won?
    (0...@num_rows).each do |row|
      (0...@num_cols).each do |col|
        return false unless @grid[row][col].is_face_up
      end
    end
    true
  end

  def reveal(row, col)
    card = @grid[row][col]
    unless card.is_face_up
      card.reveal
      card.face_value
    end
  end

end
