require_relative 'piece'
# require_relative 'board'

class Rook < Piece

  include SlidingPiece

  def move_dirs
    directions = [[0, 1], [0, -1], [0, 1], [1, 0]]
  end

  def to_s
    "R"
  end
end
