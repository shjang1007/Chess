require "colorize"

class Piece
  SYMBOLS = {
    "King" => [" \u{2654} ", " \u{265A} "],
    "Queen" => [" \u{2655} ", " \u{265B} "],
    "Rook" => [" \u{2656} ", " \u{265C} "],
    "Bishop" => [" \u{2657} ", " \u{265D} "],
    "Knight" => [" \u{2658} ", " \u{265E} "],
    "Pawn" => [" \u{2659} ", " \u{265F} "]
  }

  attr_reader :board, :color
  attr_accessor :pos

  def initialize(board, pos, color = nil)
    @board, @pos, @color = board, pos, color
  end

  def moves
  end

  def valid_moves
    moves.reject { |move| move_into_check(move) }
  end

  def to_s
    if color == :white
      SYMBOLS[self.class.to_s][0]
    elsif color == :black
      SYMBOLS[self.class.to_s][1]
    else
      "   "
    end
  end

  private

  def move_into_check(to_pos)
    dup_board = board.deep_dup

    dup_board.move_piece!(pos, to_pos)
    dup_board.in_check?(color)
  end
end
