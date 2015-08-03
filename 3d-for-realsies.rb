# http://math.stackexchange.com/questions/123642/representing-a-3d-hilbert-curve-as-an-l-system
require_relative '3d_turtle'

increase = Turtle::QUARTER_CIRCLE
decrease = -increase

turtle = Turtle.new at: {x:0, y:0, z:0}, front: {x:1}, up: {z:1}
# p at: turtle.at, front: turtle.front, up: turtle.up

4.times
 .inject("X") { |axiom, _|
  axiom.gsub /(X|Y)/, 'X' => 'XF-F+F-XF+F+XF-F+F-X' }
 .each_char { |c|
   # puts "-----  #{c} --------------------"
   # p at: turtle.at, front: turtle.front, up: turtle.up
   case c
   when 'F' then turtle.forward
   when '+' then turtle.yaw   increase
   when '-' then turtle.yaw   decrease
   when '^' then turtle.pitch increase
   when '&' then turtle.pitch decrease
   when '>' then turtle.roll  increase
   when '<' then turtle.roll  decrease
   when 'X', 'Y' then # noop
   else raise "WAT: #{c.inspect}, #{c.ord}"
   end
   # p at: turtle.at, front: turtle.front, up: turtle.up
 }
 puts turtle.trip.map { |loc| "new THREE.Vector3(#{loc.to_a.join(", ")})," }.join("\n").chomp(",")
 $stderr.puts({
   x: [turtle.trip.map(&:to_a).map { |x, y, z| x }.min, turtle.trip.map(&:to_a).map { |x, y, z| x }.max,],
   y: [turtle.trip.map(&:to_a).map { |x, y, z| y }.min, turtle.trip.map(&:to_a).map { |x, y, z| y }.max,],
   z: [turtle.trip.map(&:to_a).map { |x, y, z| z }.min, turtle.trip.map(&:to_a).map { |x, y, z| z }.max,]
 }.inspect)
