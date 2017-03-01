class ComputerPlayer < Player
  attr_reader :color, :display

  def get_moves(board)
    start_pos = find_my_pieces(board).sample
    end_pos = board[start_pos].valid_moves.sample

    [start_pos, end_pos]
  end

  # Finds the position of pieces on the board
  def find_my_pieces(board)
    my_pieces = []

    board.grid.each_with_index do |grid_row, row|
      grid_row.each_with_index do |square, col|
        pos = [row, col]
        my_pieces << pos if board[pos].color == color
      end
    end

    my_pieces
  end
end
