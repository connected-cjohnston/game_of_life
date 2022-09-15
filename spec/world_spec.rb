require './app/world'

RSpec.describe World do

  it 'should create a grid of 3 x 3' do
    world = World.new(5, 5)
    expect(world.height).to eq(5)
    expect(world.width).to eq(5)
  end

  it 'should return the cell at x, y' do
    world = World.new(5, 5)
    cell = world.cell_at(1, 1)
  end

  it 'should move the board from one state to the next' do
    world = World.new(3, 3)
    world.cell_at(1, 1).toggle!

    world.next_generation!

    expect(world.to_s).to eq('---,---,---')
  end
end
