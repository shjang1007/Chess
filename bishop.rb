class Bishop < Piece
  include SlidingPiece

  def move_dirs
    DIAGONALS
  end
end
