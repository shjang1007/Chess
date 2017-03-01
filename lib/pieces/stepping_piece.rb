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

  def stop?(pos)
    row, col = pos
    !(row.between?(0, 7) && col.between?(0, 7)) ||
      self.color == board[pos].color
  end

  def grow_unblocked_moves_in_dir(new_pos, possible_move)
    [new_pos, possible_move].transpose.map { |el| el.reduce(:+) }
  end
end
