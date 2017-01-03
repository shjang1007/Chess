class Pawn < Piece
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

  def move_dirs
    row, col = pos
    directions = []
    if color == :black
      directions << [1, 0]
      if row == 1
        directions << [2, 0]
      elsif board[[row + 1, col + 1]].color == :white
        directions << [1, 1]
      elsif board[[row + 1, col - 1]].color == :white
        directions << [1, -1]
      end
    elsif color == :white
      directions << [-1, 0]
      if row == 6
        directions << [-2, 0]
      elsif board[[row - 1, col + 1]].color == :black
        directions << [1, 1]
      elsif board[[row - 1, col - 1]].color == :black
        directions << [1, 1]
      end
    end

    directions
  end
end
