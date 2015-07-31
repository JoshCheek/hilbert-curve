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

# log = File.open("/Users/josh/deleteme/conways-game-of-life/log", "w")
# at_exit { log.close }

print "\e[H\e[2J" # clear screen
print "\e[5;0H" # move cursor to middleish of screen
at_exit { print "\e[H" } # cursor back to top

up    = "\e[A"
down  = "\e[B"
right = "\e[C"
left  = "\e[D"
n     = 4
unit  = 6.0 / (n*n)
x = y = 0

rgb1 = lambda do
  r   = (x*unit).to_i*36
  g   = (y*unit).to_i*6
  b   = (y*unit).to_i
  rgb = r + g + b
end

rgb2 = lambda do
  r   = (x*unit).to_i*36
  g   = (y*unit).to_i*6
  b   = (x*unit).to_i
  rgb = r + g + b
end

rgb = rgb1

turtle = Turtle.new :east, false do |direction, tail_up|
  colour = "\e[48;5;#{16+rgb.call}m"

  case direction
  when :north
    print "#{colour} #{left}#{up}"
    y -= 1
  when :east
    print "#{colour} #{left}#{right}"
    x += 1
  when :south
    print "#{colour} #{left}#{down}"
    y += 1
  when :west
    print "#{colour} #{left}#{left}"
    x -= 1
  else raise "WAT: #{direction.inspect}"
  end
  sleep 0.01
end

  ...... ...... ...... ...... ...... ......
  ...... ...... ...... ...... ...... ......
  ...... ...... ...... ...... ...... ......
  965... ...... ...... ...... ...... ......
  874... ...... ...... ...... ...... ......
  123... ...... ...... ...... ...... ......

fff+ff+f+f-f-f


__END__
rules  = {"A" => "-BF+AFA+FB-", "B" => "+AF-BFB-FA+"}
result = n.times.inject("A") do |a,*|
  a.gsub /[#{rules.keys.join}]/, rules
end

to_print  = result.delete("AB")
first_run = true

handle_whatevz = lambda do |c|
  case c
  when 'F' then
    turtle.orient :east if first_run
    turtle.forward!
    first_run = false
  when '-' then turtle.turn_right!
  when '+' then turtle.turn_left!
  else
  end
end

to_print.each_char &handle_whatevz
turtle.forward!
first_run = true
x = y = 0
rgb = rgb2
to_print.each_char &handle_whatevz
turtle.forward!
