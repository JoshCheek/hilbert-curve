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

rgbs = [
  lambda do
    xval = (x*unit)
    yval = (y*unit)
    zval = 1
    r = zval.to_i*36
    g = xval.to_i*6
    b = yval.to_i
    r + g + b
  end,

  # lambda do
  #   r = (x*unit).to_i*36
  #   g = (y*unit).to_i*6
  #   b = (x*unit).to_i
  #   r + g + b
  # end,

  # lambda do
  #   r = (y*unit).to_i*36
  #   g = (x*unit).to_i*6
  #   b = (x*unit).to_i
  #   r + g + b
  # end,

  # lambda do
  #   r = (x*unit).to_i*36
  #   g = (x*unit).to_i*6
  #   b = ((x+y)/2*unit).to_i
  #   r + g + b
  # end,

  # lambda do
  #   r = (x*unit).to_i*36
  #   g = ((x+y)/2*unit).to_i*6
  #   b = (x*unit).to_i
  #   r + g + b
  # end,

  # lambda do
  #   r = ((x+y)/2*unit).to_i*36
  #   g = (x*unit).to_i*6
  #   b = (x*unit).to_i
  #   r + g + b
  # end,
]

rgb = rgbs.first

turtle = Turtle.new :east, false do |direction, tail_up|
  colour = "\e[48;5;#{16+rgb.call}m"

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

rules  = {"A" => "-BF+AFA+FB-", "B" => "+AF-BFB-FA+"}
result = n.times.inject("A") do |a,*|
  a.gsub /[#{rules.keys.join}]/, rules
end

# 3d, but I don't know what most of these mean >.<
# http://martinpblogformasswritingproject.blogspot.com/2011/06/3d-hilbert-fractal-in-pyprocessing.html
# 'A': "B>F<CFC<F>D+F-D>F<1+CFC<F<B1^",
# 'B': "A+F-CFB-F-D1->F>D-1>F-B1>FC-F-A1^",
# 'C': "1>D-1>F-B>F<C-F-A1+FA+F-C<F<B-F-D1^",
# 'D': "1>CFB>F<B1>FA+F-A1+FB>F<B1>FC1^"
#
# "F", Lpos += First[Transpose[Ldir]],
# "B", Lpos -= First[Transpose[Ldir]],
# "+", Ldir = Ldir . RotMatPsi[Ldelta[[1]]];,
# "-", Ldir = Ldir . RotMatPsiII[Ldelta[[1]]];,
# "^", Ldir = Ldir . RotMatTheta[Ldelta[[2]]];,
# "&", Ldir = Ldir . RotMatThetaII[Ldelta[[2]]];,
# "<", Ldir = Ldir . RotMatPhi[Ldelta[[3]]];,
# ">", Ldir = Ldir . RotMatPhiII[Ldelta[[3]]];,
# _ , Null];

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

rgbs.each do |_rgb|
  rgb = _rgb
  first_run = true
  x = y = 0
  to_print.each_char &handle_whatevz
  # turtle.forward!
end
