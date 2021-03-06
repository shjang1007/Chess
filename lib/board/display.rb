require "colorize"

class Display
  ROWS = %w(A B C D E F G H)

  attr_reader :board, :cursor, :notification

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
    @notification = {}
  end

  def render
    system("clear")
    display_instruction
    display_board
    notification.each { |_, v| puts "#{v}".colorize(:red) }
  end

  def check_message
    @notification[:check] = "CHECK!"
  end

  def delete_check_message
    @notification.delete(:check)
  end

  private

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

  def display_instruction
    puts "Arrow keys to move"
    puts "Enter to select and place each piece"
    puts "Escape key or control + c to quit"
  end

  def background_color(row, col)
    if cursor.cursor_pos == [row, col] && cursor.selected
      background_color = :yellow
    elsif cursor.cursor_pos == [row, col]
      background_color = :light_yellow
    elsif (row + col).even?
      background_color = :light_white
    elsif (row + col).odd?
      background_color = :green
    end

    { background: background_color }
  end
end
