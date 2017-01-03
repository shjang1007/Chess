require_relative "board"
require "colorize"
require_relative "cursor"

require 'byebug'

class Display
  ROWS = %w(A B C D E F G H)

  attr_reader :board, :cursor

  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    while true
      system("clear")
      display_board
      input = cursor.get_input

      # if input == cursor.cursor_pos
      #   p input
      #   break
      # end
    end
  end

  def display_board
    puts "  #{ROWS.join(" ")}"
    puts "  - - - - - - - -"
    board.grid.each_with_index do |row, row_i|
      render_row = "#{row_i}|"
      row.each_with_index do |square, col_i|
        if [row_i, col_i] == cursor.cursor_pos
          disp_square = square.to_s.colorize(:background => :light_cyan) + " "
          render_row << disp_square
        elsif square.color.nil?
          render_row << square.to_s + " "
        else
          render_row << square.to_s + " "
        end
      end
      puts render_row
    end
  end
end

Display.new.render
