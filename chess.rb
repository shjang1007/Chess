require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game
  attr_reader :board, :display, :players, :current_player

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      white: HumanPlayer.new(:white, @display),
      black: HumanPlayer.new(:black, @display)
    }
    @current_player = :white
  end

  def play
    until game_over?
      begin
        start_pos, end_pos = players[current_player].get_moves(board)
        board.move_piece(current_player, start_pos, end_pos)

        switch_player!
      rescue => e
        puts e
        sleep(1)
        retry
      end
    end
    @display.render
    puts "Checkmate! #{winner} wins!!"
  end

  private

  def game_over?
    board.checkmate?(:white) || board.checkmate?(:black)
  end

  def switch_player!
    @current_player = current_player == :white ? :black : :white
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
