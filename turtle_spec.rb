# note: add up/down/left/right/forward/backward


RSpec.describe Turtle do
  specify 'by default, it has a vector of 0, 0, 0, 0' do
    expect(Turtle.new.vec).to eq [0, 0, 0, 0]
  end

  specify 'it can rotate on the x-axis' do
    expect(Turtle.new.rotate_x(45)).to eq [0, 45, 0, 0]
    expect(Turtle.new.rotate_x(-45)).to eq [0, 315, 0, 0]
  end

  specify 'it can rotate on the y-axis' do
    expect(Turtle.new.rotate_y(45)).to eq [0, 0, 45, 0]
    expect(Turtle.new.rotate_y(-45)).to eq [0, 0, 315]
  end

  specify 'it can rotate on the the z-axis' do
    expect(Turtle.new.rotate_z(45)).to eq [0, 0, 0, 45]
    expect(Turtle.new.rotate_z(-45)).to eq [0, 0, 0, 315]
  end

  specify 'its angles roll over at 360' do
    turtle = Turtle.new.rotate_x(359)
    expect(turtle.vec).to eq [0, 359, 0, 0]
    turtle.rotate_x(1)
    expect(turtle.vec).to eq [0, 0, 0, 0]
  end

  let(:sq2) { Math.sqrt 2 }

  it 'moves forward along its vector' do
    turtle = Turtle.new.rotate_x(45)
    turtle.rotate_x(45).forward(1)
    expect(turtle.vec).to eq [1, 45, 0, 0]
    turtle.rotate_x(-90).forward(1)
    expect(turtle.vec).to eq [sq2, -45, 0, 0]
    expect(turtle.xyz).to eq [0, -sq2, -sq2]

    turtle = Turtle.new.rotate_y(45)
    turtle.rotate_y(45).forward(1)
    expect(turtle.vec).to eq [1, 0, 45, 0]
    turtle.rotate_y(-90).forward(1)
    expect(turtle.vec).to eq [sq2, 0, -45, 0]
    expect(turtle.xyz).to eq [-sq2, 0, -sq2]

    turtle = Turtle.new.rotate_z(45)
    turtle.rotate_z(45).forward(1)
    expect(turtle.vec).to eq [1, 0, 0, 45]
    turtle.rotate_z(-90).forward(1)
    expect(turtle.vec).to eq [sq2, 0, 0, -45]
    expect(turtle.xyz).to eq [sq2, sq2, 0]

    turtle = Turtle.new.rotate_x(45).rotate_y(45).rotate_z(45).forward(2)
    expect(turtle.vec).to eq [2, 45, 45, 45]
  end

  it 'translates its vector to x, y, z coordinates' do
    turtle = Turtle.new.rotate_x(90).forward(1).rotate_y(90).forward(1)
    expect(turtle.vec).to eq [1, 45, 45, 0]
  end

  it 'translates changes in roll/pitch/rotate_z into the objective roll/pitch/rotate_z'
end
