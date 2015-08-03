require_relative 'turtle'

RSpec.describe Turtle do
  let(:increase) { Math::PI/2 }
  let(:decrease) { -increase }

  it 'can rotate about all axes and move in the specified direction' do
    turtle = Turtle.new at: {x:0, y:0, z:0}, front: {x:1}, up: {z: 1}
    turtle
      .assert_at(at: {x:0, y:0, z:0}, front: {x:1}, up: {z:1}, left: {y:1})
        .forward.yaw(increase).assert_at(at: {x: 1, y: 0})
        .forward.yaw(increase).assert_at(at: {x: 1, y: 1})
        .forward.yaw(increase).assert_at(at: {x: 0, y: 1})
        .forward.yaw(increase).assert_at(at: {x: 0, y:  0})
      .assert_at(at: {x:0, y:0, z:0}, front: {x:1}, up: {z:1})
        .forward.yaw(decrease).assert_at(at: {x: 1, y: 0})
        .forward.yaw(decrease).assert_at(at: {x: 1, y: -1})
        .forward.yaw(decrease).assert_at(at: {x: 0, y: -1})
        .forward.yaw(decrease).assert_at(at: {x: 0, y: 0})
      .assert_at(at: {x:0, y:0, z:0}, front: {x:1}, up: {z:1})
        .pitch(increase).forward.assert_at(at: {x:  0, z: 1})
        .pitch(increase).forward.assert_at(at: {x: -1, z: 1})
        .pitch(increase).forward.assert_at(at: {x: -1, z: 0})
        .pitch(increase).forward.assert_at(at: {x:  0, z: 0})
      .assert_at(at: {x:0, y:0, z:0}, front: {x:1}, up: {z:1})
        .pitch(decrease).forward.assert_at(at: {x:  0, z: -1})
        .pitch(decrease).forward.assert_at(at: {x: -1, z: -1})
        .pitch(decrease).forward.assert_at(at: {x: -1, z:  0})
        .pitch(decrease).forward.assert_at(at: {x:  0, z:  0})
      .assert_at(at: {x:0, y:0, z:0}, front: {x:1}, up: {z:1})
        .roll(increase).assert_at(at: {x:0, y:0, z:0}, front: {x:1}, left: {z:1})
        .pitch(increase).forward.assert_at(at: {x:  0, y: -1})
        .pitch(increase).forward.assert_at(at: {x: -1, y: -1})
        .pitch(increase).forward.assert_at(at: {x: -1, y:  0})
        .pitch(increase).forward.assert_at(at: {x:  0, y:  0})
        .roll(decrease)
      .assert_at(at: {x:0, y:0, z:0}, front: {x:1}, up: {z:1})
        .roll(decrease)
        .forward.pitch(decrease).assert_at(at: {x: 1, y:  0})
        .forward.pitch(decrease).assert_at(at: {x: 1, y: -1})
        .forward.pitch(decrease).assert_at(at: {x: 0, y: -1})
        .forward.pitch(decrease).assert_at(at: {x: 0, y:  0})
        .roll(increase)
      .assert_at(at: {x:0, y:0, z:0}, front: {x:1}, up: {z:1})
        .roll(increase)  .assert_at(front: {x: 1}, up: {y:-1})
        .pitch(increase) .assert_at(front: {y:-1}, up: {x:-1})
        .roll(increase)  .assert_at(front: {y:-1}, up: {z:-1})
        .yaw(decrease)   .assert_at(front: {x: 1}, up: {z:-1})
        .forward
        .forward
        .yaw(increase).yaw(increase)
        .forward
        .forward
        .pitch(increase).pitch(increase)
      .assert_at(at: {x:0, y:0, z:0}, front: {x:1}, up: {z:1})

    expect(turtle.trip).to eq [
      [  0,  0,  0],
      [  1,  0,  0],
      [  1,  1,  0],
      [  0,  1,  0],
      [  0,  0,  0],
      [  1,  0,  0],
      [  1, -1,  0],
      [  0, -1,  0],
      [  0,  0,  0],
      [  0,  0,  1],
      [ -1,  0,  1],
      [ -1,  0,  0],
      [  0,  0,  0],
      [  0,  0, -1],
      [ -1,  0, -1],
      [ -1,  0,  0],
      [  0,  0,  0],
      [  0, -1,  0],
      [ -1, -1,  0],
      [ -1,  0,  0],
      [  0,  0,  0],
      [  1,  0,  0],
      [  1, -1,  0],
      [  0, -1,  0],
      [  0,  0,  0],
      [  1,  0,  0],
      [  2,  0,  0],
      [  1,  0,  0],
      [  0,  0,  0],
    ].map { |x, y, z| Vector[x, y, z] }
  end
end
