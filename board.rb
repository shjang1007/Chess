require_relative "piece"
require_relative "bishop"
require_relative "king"
require_relative "knight"
require_relative "pawn"
require_relative "queen"
require_relative "rook"
require_relative "null_pieces"

require 'byebug'

class Board
  attr_accessor :grid

  def initialize
    generate_board
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

  def move_piece(color, start_pos, end_pos)
    piece_selected = self[start_pos]

    if piece_selected.is_a?(NullPiece)
      raise "Empty square selected"
    elsif piece_selected.color != color
      raise "You have selected the wrong color piece"
    elsif invalid_move?(start_pos, end_pos)
      raise "Invalide move"
    end

    move_piece!(start_pos, end_pos)
  end

  # same method as the above one, but created to avoid method collision
  def move_piece!(start_pos, end_pos)
    update_the_board_after_move(start_pos, end_pos)
  end

  def update_the_board_after_move(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos].pos = end_pos
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

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  private

  def generate_board
    @grid = Array.new(8) { Array.new(8) }
    place_pieces
  end

  def place_pieces
    place_back_pieces
    place_pawns_and_nullpieces
  end

  def place_pawns_and_nullpieces
    grid.each_with_index do |grid_row, row|
      grid_row.each_index do |col|
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

  def place_back_pieces
    grid[0] = back_pieces(0,:black)
    grid[7] = back_pieces(7, :white)
  end

  def back_pieces(row, color)
    [Rook.new(self, [row, 0], color),
      Knight.new(self, [row, 1], color),
      Bishop.new(self, [row, 2], color),
      Queen.new(self, [row, 3], color),
      King.new(self, [row, 4], color),
      Bishop.new(self, [row, 5], color),
      Knight.new(self, [row, 6], color),
      Rook.new(self, [row, 7], color)]
  end

  def find_king_position(color)
    grid.flatten.find { |piece| piece.is_a?(King) && piece.color == color }.pos
  end

  def diff_color_pieces(color)
    grid.flatten.select { |piece| piece.color != color && !piece.color.nil? }
  end

  def same_color_pieces(color)
    grid.flatten.select { |piece| piece.color == color }
  end

  #need to modify this to raise different error for the move in check
  def invalid_move?(start_pos , end_pos)
    !self[start_pos].valid_moves.include?(end_pos)
  end
end
