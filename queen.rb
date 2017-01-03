class Queen < Piece

  include SlidingPiece

  def move_dirs
    HORIZONTAL + VERTICAL + DIAGONALS
  end
end
