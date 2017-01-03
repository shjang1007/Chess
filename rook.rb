require_relative "piece"

class Rook < Piece
  include SlidingPiece

  def move_dirs
    HORIZONTAL + VERTICAL
  end

  def to_s
    "R"
  end
end
