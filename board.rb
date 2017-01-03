require_relative "rook"
require_relative "piece"

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    place_pieces
  end

  def place_pieces
    chess_piece_rows = [0, 1, 6, 7]
    chess_piece_rows.each do |row|
      grid[row].each_index do |col|
        grid[row][col] = Piece.new([row, col], self)
      end
    end

    grid[2][2] = Rook.new([2, 2], self)
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def move_piece(start_pos, end_pos)
    # Probably need to modify in the future
    raise "There is no piece to move from." if self[start_pos].nil?
    # raise "Invalid move." if self[start_pos].valid_move?(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end
end
