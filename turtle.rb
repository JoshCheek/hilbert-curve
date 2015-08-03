class Turtle
  attr_accessor :on_move, :directions

  def initialize(&on_move)
    self.on_move    = on_move
    self.directions = [:north, :east, :south, :west]
  end

  def orient(direction)
    turn_right! until facing? direction
  end

  def turn_right!
    directions.rotate! 1
  end

  def turn_left!
    directions.rotate! -1
  end

  def facing?(direction)
    self.direction == direction
  end

  def direction
    directions.first
  end

  def forward!
    on_move.call direction
  end
end
