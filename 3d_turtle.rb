require 'quaternion'

class Turtle
  FULL_CIRCLE    = 2*Math::PI
  HALF_CIRCLE    = Math::PI
  QUARTER_CIRCLE = Math::PI/2

  def initialize(at:, front:, up:)
    self.at = vector at
    oh_the_places_you_went << at()
    set_angles vector(front).normalize, vector(up).normalize
  end

  def assert_at(at:nil, front:nil, up:nil, left:nil)
    assert_xyz :position, at,    at()
    assert_xyz :front,    front, front()
    assert_xyz :up,       up,    up()
    assert_xyz :left,     left,  left()
    self
  end

  def forward
    self.at += front
    oh_the_places_you_went << at
    self
  end

  # positive is towards the left
  def yaw(radians)
    set_angles rotate(front, around: up, by: radians), up
    self
  end

  # positive is towards up, idk if that's how it's supposed to be,
  # there's a dearth of precise definitions out there
  def pitch(radians)
    set_angles rotate(front, around: right, by: radians),
               rotate(up,    around: right, by: radians)
    self
  end

  # positive is towards the right
  def roll(radians)
    set_angles front, rotate(up, around: front, by: radians)
    self
  end

  def trip
    oh_the_places_you_went.map(&:dup)
  end

  private

  attr_accessor :at
  attr_reader :front, :up

  def rotate(location, around:, by:)
    xyz = Quaternion.rotation(around, by)
                    .rotate(location)
                    .to_a.map { |n| (n*10000).to_i / 10000.0 }
    Vector[*xyz]
  end

  def vector(x:0, y:0, z:0)
    Vector[x, y, z]
  end

  def left
    rotate front, around: up, by: QUARTER_CIRCLE
  end

  def right
    rotate up, around: front, by: QUARTER_CIRCLE
  end

  def oh_the_places_you_went
    @oh_the_places_you_went ||= []
  end

  # do them both at once to prevent errors from calculating one baased on the other's old value (ie by using right or left)
  def set_angles(front, up)
    front.angle_with(up) == Math::PI/2 or
      raise ArgumentError, "front (#{front.inspect} and up #{up.inspect} must be orthogonal (90 degree angle)"
    @front, @up = front, up
  end

  def assert_xyz(name, expected_xyz, actual)
    return unless expected_xyz
    expected_xyz.each do |key, value|
      index = {x:0, y:1, z:2}[key]
      next if (value - actual[index]).abs < 0.00001
      raise "#{name}: #{expected_xyz.inspect}[#{key.inspect}] = #{value.inspect} Was expected to equal: #{actual.inspect}[#{index.inspect}] = #{actual[index].inspect}"
    end
  end
end
