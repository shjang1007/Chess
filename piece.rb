module SlidingPiece
  def moves
    moves = []
    move_dirs.each do |possible_move|
      new_pos = pos
      while true
        new_pos = [new_pos, possible_move].transpose.map { |el| el.reduce(:+) }
        break unless valid_move?(new_pos)
        moves << new_pos
      end
    end

    moves
  end

  def valid_move?(pos)
    row, col = pos
    (row.between?(0, 7) && col.between?(0, 7)) #&& board[pos].nil?
  end

  def grow_unblocked_moves_in_dir(dx, dy)
  end
end
#
# module SteppingPiece
# end

class Piece
  attr_reader :board, :pos, :color

  def initialize(board, pos, color = nil)
    @board, @pos, @color = board, pos, color
  end

  def moves
  end

  def empty?()
  end

  def symbol()
  end

  def to_s
    "_"
  end

  private

  def move_into_check(to_pos)
  end
end
