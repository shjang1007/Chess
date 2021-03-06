# One module to handle Rook, Queen, and Bishop's moves
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

  private

  def different_color_piece?(pos)
    return false if pos.is_a?(NullPiece)

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
