class Knight < Piece

  include SteppingPiece

  def move_dirs
    [ [-2, 1], [-2, -1], [2, 1], [2, -1], [1, -2], [-1, -2], [1, 2], [-1, 2] ]
  end

  def to_s
    if color == :white
      "N".colorize(:yellow)
    else
      "N"
    end
  end
end
