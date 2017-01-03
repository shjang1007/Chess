module SteppingPiece
  def moves
    moves = []
    move_dirs.each do |possible_move|
        new_pos = grow_unblocked_moves_in_dir(pos, possible_move)
        # Stops when the pos is out of grid
        # Stops when the pos is blocked
        next if stop?(new_pos)
        moves << new_pos
    end

    moves
  end

  def different_color_piece?(pos)
    return false if pos.nil?

    last_move_color = board[pos].color

    if self.color == :white
      last_move_color == :black
    else
      last_move_color == :white
    end
  end

  def stop?(pos)
    row, col = pos
    !(row.between?(0, 7) && col.between?(0, 7)) ||
      self.color == board[pos].color
  end

  def grow_unblocked_moves_in_dir(new_pos, possible_move)
    [new_pos, possible_move].transpose.map { |el| el.reduce(:+) }
  end
end

class Piece
  attr_reader :board, :color
  attr_accessor :pos

  def initialize(board, pos, color = nil)
    @board, @pos, @color = board, pos, color
  end

  def moves
  end

  def empty?()
  end

  def symbol()
  end

  def to_s
    "_"
  end

  private

  def move_into_check(to_pos)
  end
end

module SlidingPiece
  HORIZONTAL = [[0, 1], [0, -1]]
  VERTICAL = [[1, 0], [-1, 0]]
  DIAGONALS = [[1, 1], [-1, -1], [-1, 1], [1, -1]]

  def moves
    moves = []
    move_dirs.each do |possible_move|
      new_pos = pos
      while true
        new_pos = grow_unblocked_moves_in_dir(new_pos, possible_move)
        # Stops when the pos is out of grid
        # Stops when the pos is blocked
        break if stop?(new_pos)
        moves << new_pos

        # Stops when the pos is after the different color piece
        break if different_color_piece?(new_pos)
      end
    end

    moves
  end

  def different_color_piece?(pos)
    return false if pos.nil?

    last_move_color = board[pos].color

    if self.color == :white
      last_move_color == :black
    else
      last_move_color == :white
    end
  end

  def stop?(pos)
    row, col = pos
    !(row.between?(0, 7) && col.between?(0, 7)) ||
      self.color == board[pos].color
  end

  def grow_unblocked_moves_in_dir(new_pos, possible_move)
    [new_pos, possible_move].transpose.map { |el| el.reduce(:+) }
  end
end
