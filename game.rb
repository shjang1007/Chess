require_relative "invalid_move_error"
require_relative "board"
require_relative "display"
require_relative "cursor"
require_relative "piece"
require_relative "bishop"
require_relative "king"
require_relative "knight"
require_relative "pawn"
require_relative "queen"
require_relative "rook"
require_relative "null_pieces"
require_relative "human_player"

class Game
  attr_reader :board, :player1, :player2, :current_player

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(:white, @display)
    @player2 = HumanPlayer.new(:black, @display)
    @current_player = @player1
  end

  def play
    until game_over
      play_turn
    end
  end

  def game_over
    board.checkmate?(:white) || board.checkmate?(:black)
  end

  def play_turn
    begin
      moves = current_player.get_moves(board)
      start_pos = moves[0]
      end_pos = moves[1]
      board.move_piece(current_player.color, start_pos, end_pos)
    rescue => error
      puts error.message
      retry
    end

    switch_players!
  end

  def switch_players!
    @current_player = current_player.color == :white ? player2 : player1
  end
end

if $PROGRAM_NAME == __FILE__
  new_game = Game.new
  new_game.play
end
