require_relative "piece"
require_relative "bishop"
require_relative "king"
require_relative "knight"
require_relative "pawn"
require_relative "queen"
require_relative "rook"
require_relative "null_pieces"

class Board
  attr_accessor :grid

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

  def checkmate?(color)
    in_check?(color) &&
    same_color_pieces(color).all? { |piece| piece.valid_moves.empty?}
  end

  def in_check?(color)
    king_pos = find_king_position(color)
    diff_color_pieces(color).any? do |piece|
      piece.moves.include?(king_pos)
    end
  end

  def find_king_position(color)
    (0..7).each do |row|
      (0..7).each do |col|
        pos = [row, col]
        return pos if self[pos].is_a?(King) && self[pos].color == color
      end
    end
  end

  def diff_color_pieces(color)
    grid.flatten.select { |piece| piece.color != color && !piece.color.nil? }
  end

  def same_color_pieces(color)
    grid.flatten.select { |piece| piece.color == color }
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def deep_dup
    dup_board = self.dup
    dup_board.grid = Array.new(8) { Array.new(8) }
    grid.each_with_index do |row, row_i|
      row.each_with_index do |square, col_i|
        pos = [row_i, col_i]
        if square.is_a?(NullPiece)
          dup_board[pos] = NullPiece.instance
        else
          dup_board[pos] = square.class.new(dup_board, pos, square.color)
        end
      end
    end

    dup_board
  end

  ##################### REFACTOR!!! ################################
  def move_piece(color, start_pos, end_pos)
    piece_selected = self[start_pos]
    if piece_selected.is_a?(NullPiece)
      raise "Empty square selected"

    unless piece_selected.valid_moves.include?(end_pos)
      raise "That move will leave you in check" if in_check?(piece_selected.color)
      raise "Invalid move."
    end

    move_piece!(start_pos, end_pos)
  end

  # same method as the above one, but created to avoid method collision
  def move_piece!(start_pos, end_pos)
    update_the_board_after_move(start_pos, end_pos)
  end

  def update_the_board_after_move(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[pos] = NullPiece.instance
    self[end_pos].pos = end_pos
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
      Queen.new(self, [row, 3], color),
      King.new(self, [row, 4], color),
      Bishop.new(self, [row, 5], color),
      Knight.new(self, [row, 6], color),
      Rook.new(self, [row, 7], color)]
  end
end
