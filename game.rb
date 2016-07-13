require_relative 'board'
require_relative 'card'
require_relative 'human_player'
require_relative 'computer_player'

class Game

  def initialize(n, m, *players)
    @board = Board.new(n,m)
    @prev_guess = nil
    @prev_guess_value = nil
    @current_player = players[0]
    @players = players
    @players.each {|player| player.compute_unknown_positions(n, m)}
    @turn_counter = 0
  end

  def play
    @board.populate
    @board.render
    until @board.won?
      puts "current_player is #{@current_player.name}"
      pos = get_guess
      make_guess(pos)
      @turn_counter += 1
      switch_player! if @turn_counter % 2 == 0 && !@board.won?
    end
    puts "#{@current_player.name} won!"
  end

  def switch_player!
    @players.rotate!
    @current_player = @players.first
  end

  def get_guess
    guess = @current_player.get_input(@prev_guess, @prev_guess_value)
    until valid_guess?(guess)
      puts "Not a valid guess. Please try again"
      guess = @player.get_input(@prev_guess, @prev_guess_value)
    end
    guess
  end

  def valid_guess?(pos)
    x, y = pos[0], pos[1]
    unless (0...@board.num_cols).include?(y) &&
     (0...@board.num_rows).include?(x)
      return false
    end
    !@board.grid[x][y].is_face_up
  end

  def make_guess(pos)
    x, y = pos[0], pos[1]
    #system('clear')
    @board.reveal(x, y)
    @current_player.receive_revealed_card(pos, @board.grid[x][y].face_value)
    @board.render
    if @prev_guess.nil?
      @prev_guess = pos
      @prev_guess_value = @board.grid[@prev_guess[0]][@prev_guess[1]].face_value
    else
      check_match(pos)
    end
  end

  def check_match(pos)
    x, y = pos[0], pos[1]
    prev_x, prev_y = @prev_guess[0], @prev_guess[1]
    if @board.grid[x][y] == @board.grid[prev_x][prev_y]
      puts "You got a match!"
      @current_player.receive_match(pos, @prev_guess, @prev_guess_value)
    else
      sleep(1)
      #system('clear')
      puts "Sorry. That's not a match."
      @board.grid[x][y].hide
      @board.grid[prev_x][prev_y].hide
      @board.render
    end
    @prev_guess = nil
    @prev_guess_value = nil
  end

end

if __FILE__ == $PROGRAM_NAME
  computer = ComputerPlayer.new
  human = HumanPlayer.new("lily")
  game = Game.new(2,3, computer, human)
  game.play
end
