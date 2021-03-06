require 'singleton'

class NullPiece < Piece
  attr_reader :color

  include Singleton

  def initialize
    @color = nil
  end

  def symbol
    :null
  end
end
