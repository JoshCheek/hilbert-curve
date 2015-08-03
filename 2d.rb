class Turtle
  attr_accessor :on_move, :directions, :tail_up

  def initialize(orient, tial_up, &on_move)
    self.tail_up    = tail_up
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
    on_move.call direction, tail_up
  end

  def tail_up!
    self.tail_up = true
  end

  def tail_down!
    self.tail_up = false
  end
end

print "\e[H\e[2J"        # clear screen
print "\e[5;0H"          # move cursor to middleish of screen
at_exit { print "\e[H" } # cursor back to top

up    = "\e[A"
down  = "\e[B"
right = "\e[C"
left  = "\e[D"
x = y = 0

turtle = Turtle.new :east, false do |direction, tail_up|
  colour = "\e[48;5;#{16+rand(5).next*36+rand(5).next*6+rand(5).next}m"

  case direction
  when :north
    print "#{colour}  #{left}#{left}#{up}"
    print "#{colour}  #{left}#{left}#{up}"
    y -= 1
  when :east
    print "#{colour}  #{left}#{left}#{right}"
    print "#{colour}  #{left}#{left}#{right}"
    print "#{colour}  #{left}#{left}#{right}"
    print "#{colour}  #{left}#{left}#{right}"
    x += 1
  when :south
    print "#{colour}  #{left}#{left}#{down}"
    print "#{colour}  #{left}#{left}#{down}"
    y += 1
  when :west
    print "#{colour}  #{left}#{left}#{left}"
    print "#{colour}  #{left}#{left}#{left}"
    print "#{colour}  #{left}#{left}#{left}"
    print "#{colour}  #{left}#{left}#{left}"
    x -= 1
  else raise "WAT: #{direction.inspect}"
  end
  sleep 0.05
end

turtle.orient :east

rules  = {
  "A" => "-BF+AFA+FB-",
  "B" => "+AF-BFB-FA+",
}

production = (ARGV[0]||4).times.inject("A") do |a,*|
  a.gsub /[#{rules.keys.join}]/, rules
end

production.each_char do |c|
  case c
  when 'F' then turtle.forward!
  when '-' then turtle.turn_right!
  when '+' then turtle.turn_left!
  else # no op
  end
end
