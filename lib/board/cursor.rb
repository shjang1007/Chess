require "io/console"

KEYMAP = {
  "\r" => :return,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\u0003" => :ctrl_c,
  "\e" => :escape
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false

    STDIN.raw!

    input = STDIN.getc.chr

    if input == "\e"
      input << STDIN.read_nonblock(3) rescue nil

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def handle_key(key)
    case key
    when :return, :space
      toggle_selected
      cursor_pos
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      nil
    when :ctrl_c, :escape
      exit 0
    else
      # Return nothing when it's not one of the key
      return
    end
  end

  def toggle_selected
    @selected = !@selected
  end

  def update_pos(diff)
    row, col = cursor_pos
    x , y = diff
    @cursor_pos = [row + x, col + y] if in_bounds?([row + x, col + y])
  end

  def in_bounds?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end
end
