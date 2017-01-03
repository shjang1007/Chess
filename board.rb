require_relative "piece"
require_relative "bishop"
require_relative "king"
require_relative "knight"
require_relative "pawn"
require_relative "queen"
require_relative "rook"
require_relative "null_pieces"

require "byebug"

class Board
  attr_reader :grid

  def initialize
    generate_board
  end

  def generate_board
    @grid = Array.new(8) { Array.new(8) }
    place_pieces
  end

  def display_board
    puts "  #{(0..7).to_a.join(" ")}"
    grid.each_with_index do |row, i|
      puts "#{i} #{row.join(" ")}"
    end
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
    raise "There is no piece to move from." if self[start_pos].nil?
    raise "Invalid move." unless self[start_pos].moves.include?(end_pos)

    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = NullPiece.instance
  end

  def place_pieces
    grid.each_with_index do |row_v, row|
      if row == 0
        grid[row] = non_pawn_pieces(row, :black)
      elsif row == 7
        grid[row] = non_pawn_pieces(row, :white)
      end
      row_v.each_index do |col|
        pos = [row, col]
        case row
        when 1
          self[pos] = Pawn.new(self, pos, :black)
        when 6
          self[pos] = Pawn.new(self, pos, :white)
        when 2, 3, 4, 5
          self[pos] = NullPiece.instance
        end
      end
    end
  end

  def non_pawn_pieces(row, color)
    [Rook.new(self, [row, 0], color),
      Knight.new(self, [row, 1], color),
      Bishop.new(self, [row, 2], color),
      King.new(self, [row, 3], color),
      Queen.new(self, [row, 4], color),
      Bishop.new(self, [row, 5], color),
      Knight.new(self, [row, 6], color),
      Rook.new(self, [row, 7], color)]
  end
end

# a = Board.new
# start_pos = [1, 3]
# end_pos = [3, 3]
# a.move_piece(start_pos, end_pos)
# a.move_piece([6, 2], [4, 2])
# a.display_board
# p a[end_pos].moves
