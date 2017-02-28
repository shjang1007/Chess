class HumanPlayer
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def get_moves(board)
    start_pos, end_pos = nil, nil

    until start_pos && end_pos
      display.render

      if start_pos
        puts "#{color}'s turn. Move to where?"
        end_pos = display.cursor.get_input
      else
        puts "#{color}'s turn. Move from where?"
        start_pos = display.cursor.get_input
      end
    end

    [start_pos, end_pos]
  end
end
