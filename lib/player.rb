# Class to hold player values and methods
class Player
  attr_accessor :name, :symbol, :moves

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @moves = []
  end

  def save_move(block_index)
    moves << block_index
  end
end
