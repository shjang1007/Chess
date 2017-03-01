class Pawn < Piece
  def moves
    row, col = pos

    forward_moves = []
    forward_moves << fwd_pos unless board.occupied?(fwd_pos)
    forward_moves << double_fwd_pos if row == starting_pos? &&
                                      !board.occupied?(double_fwd_pos)

    forward_moves + diagonal_attack_pos
  end

  private

  def starting_pos?
    color == :black ? 1 : 6
  end

  def fwd_pos
    row, col = pos
    color == :black ? [row + 1, col] : [row - 1, col]
  end

  def double_fwd_pos
    row, col = pos
    color == :black ? [row + 2, col] : [row - 2, col]
  end

  def diagonal_coordinates
    color == :black ? [ [1, 1], [1, -1]] : [ [-1, 1], [-1, -1]]
  end

  def diagonal_attack_pos
    diagonal_attack_pos = []

    diagonal_coordinates.each do |coordinate|
      possible_pos = [pos, coordinate].transpose.map { |el| el.reduce(:+) }

      if board.occupied?(possible_pos) && board[possible_pos].color != color
        diagonal_attack_pos << possible_pos
      end
    end

    diagonal_attack_pos
  end
end
