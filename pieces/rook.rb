require_relative "piece"

class Rook < Piece
  include SlidingPiece

  def move_dirs
    HORIZONTAL + VERTICAL
  end
end
