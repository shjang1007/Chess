require_relative "compile_load"

class Game
  attr_reader :board, :player1, :player2, :current_player, :display

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
      check_notification
    end

    display.render
    puts "Checkmate! #{winner} wins!!"
  end

  private

  def game_over
    board.checkmate?(:white) || board.checkmate?(:black)
  end

  def play_turn
    begin
      start_pos, end_pos = current_player.get_moves(board)
      board.move_piece(current_player.color, start_pos, end_pos)

      reset_error_notification!
    rescue => error
      display.notification[:error] = error.message
      retry
    end

    switch_players!
  end

  def switch_players!
    @current_player = current_player.color == :white ? player2 : player1
  end

  def winner
    board.checkmate?(:white) ? "Black" : "White"
  end

  def reset_error_notification!
    display.notification.delete(:error)
  end

  def check_notification
    board.in_check?(current_player.color) ?
      display.check_message : display.delete_check_message
  end
end

if $PROGRAM_NAME == __FILE__
  new_game = Game.new
  new_game.play
end
