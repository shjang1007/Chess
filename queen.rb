class Queen < Piece

  include SlidingPiece

  def move_dirs
    HORIZONTAL + VERTICAL + DIAGONALS
  end

  def to_s
    "Q"
  end
end
