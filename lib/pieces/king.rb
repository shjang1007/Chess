class King < Piece
  HORIZONTAL = [[0, 1], [0, -1]]
  VERTICAL = [[1, 0], [-1, 0]]
  DIAGONALS = [[1, 1], [-1, -1], [-1, 1], [1, -1]]

  include SteppingPiece

  def move_dirs
    HORIZONTAL + VERTICAL + DIAGONALS
  end
end
