require "colorize"

class Display
  ROWS = %w(A B C D E F G H)

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
      system("clear")
      display_board
  end

  def display_board
    puts "  #{ROWS.join("  ")}"
    board.grid.each_with_index do |grid_row, row|
      render_row = "#{row + 1}"
      grid_row.each_with_index do |square, col|
          render_row << square.to_s.colorize(background_color(row, col))
      end
      puts "#{render_row}#{row + 1}"
    end
    puts "  #{ROWS.join("  ")}"
  end

  def background_color(row, col)
    if cursor.cursor_pos == [row, col] && cursor.selected
      background_color = :red
    elsif cursor.cursor_pos == [row, col]
      background_color = :cyan
    elsif (row + col).even?
      background_color = :light_yellow
    elsif (row + col).odd?
      background_color = :light_green
    end

    { background: background_color }
  end
end
