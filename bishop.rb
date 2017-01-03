class Bishop < Piece
  include SlidingPiece

  def move_dirs
    DIAGONALS
  end

  def to_s
    "B"
  end
end
