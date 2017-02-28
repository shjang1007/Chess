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

module SlidingPiece
  HORIZONTAL = [[0, 1], [0, -1]]
  VERTICAL = [[1, 0], [-1, 0]]
  DIAGONALS = [[1, 1], [-1, -1], [-1, 1], [1, -1]]

  def moves
    moves = []
    move_dirs.each do |possible_move|
      new_pos = pos
      while true
        new_pos = grow_unblocked_moves_in_dir(new_pos, possible_move)
        # Stops when the pos is out of grid
        # Stops when the pos is blocked
        break if stop?(new_pos)
        moves << new_pos

        # Stops when the pos is after the different color piece
        break if different_color_piece?(new_pos)
      end
    end

    moves
  end

  def different_color_piece?(pos)
    return false if pos.is_a?(NullPiece)

    last_move_color = board[pos].color

    if self.color == :white
      last_move_color == :black
    else
      last_move_color == :white
    end
  end

  def stop?(pos)
    row, col = pos
    !(row.between?(0, 7) && col.between?(0, 7)) ||
      self.color == board[pos].color
  end

  def grow_unblocked_moves_in_dir(new_pos, possible_move)
    [new_pos, possible_move].transpose.map { |el| el.reduce(:+) }
  end
end

module SteppingPiece
  def moves
    moves = []
    move_dirs.each do |possible_move|
        new_pos = grow_unblocked_moves_in_dir(pos, possible_move)
        # Stops when the pos is out of grid
        # Stops when the pos is blocked
        next if stop?(new_pos)
        moves << new_pos
    end

    moves
  end

  def stop?(pos)
    row, col = pos
    !(row.between?(0, 7) && col.between?(0, 7)) ||
      self.color == board[pos].color
  end

  def grow_unblocked_moves_in_dir(new_pos, possible_move)
    [new_pos, possible_move].transpose.map { |el| el.reduce(:+) }
  end
end