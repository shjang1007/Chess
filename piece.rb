# require_relative 'board'
#
module SlidingPiece
  def moves
    move_dirs

    moves = []
    move_dirs.each do |possible_move|
      while true
        # everytime it resets pos, so it runs infinitely
        new_pos = [pos, possible_move].transpose.map { |el| el.reduce(:+) }
        break unless valid_move?(new_pos)
        moves << new_pos
      end
    end

    moves
  end

  def valid_move?(pos)
    row, col = pos
    (row.between?(0, 7) && col.between?(0, 7)) && board[pos].nil?
  end
  #
  # def horizontal_dirs()
  # end
  #
  # def diagonal_dirs()
  # end

  def grow_unblocked_moves_in_dir(dx, dy)
  end
end
#
# module SteppingPiece
# end

class Piece
  attr_reader :pos, :board

  def initialize(pos, board)
    @pos = pos
    @board = board
  end

  def moves
  end

  def empty?()
  end

  def symbol()
  end

  def to_s
    "P"
  end

  private

  def move_into_check(to_pos)
  end
end
