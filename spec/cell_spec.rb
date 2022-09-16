require './app/cell'
require './app/world'

# 1. LONELINESS:
#   - Living cells die if they have fewer than two neighbours
#
# 2. OVERPOPULATION:
#   - Living cells die if they have more than three neighbours
#
# 3. REPRODUCTION:
#   - Dead cells that have exactly three neighbours become alive
#
# 4. NO CHANGE OTHERWISE:
#   - Whether cell is alive or dead
#

RSpec.describe Cell do
  let(:world) { World.new(3, 3) }

  it 'should initialize dead' do
    cell = Cell.new(world, 1, 1)
    expect(cell.alive?).to eq(false)
  end

  it 'should initialize at the given location' do
    cell = Cell.new(world, 1, 1)
    expect(cell.x).to eq(1)
    expect(cell.y).to eq(1)
  end

  it 'should toggle its state' do
    cell = Cell.new(world, 1, 1)
    cell.toggle!
    expect(cell.alive?).to eq(true)
  end

  it 'should return number of alive neighbours' do
    cell = Cell.new(world, 1, 1)
    expect(cell.neighbours).to eq(0)
  end

  it 'should return number of alive neighbours when there are 2 neighbours' do
    world.cell_at(0, 0).toggle!
    world.cell_at(0, 1).toggle!

    cell = Cell.new(world, 1, 1)
    expect(cell.neighbours).to eq(2)
  end

  it 'should return number of alive neighbours when there are 2 neighbours' do
    world.cell_at(0, 0).toggle!
    world.cell_at(0, 1).toggle!

    cell = world.cell_at(1, 1)
    cell.toggle!

    expect(cell.neighbours).to eq(2)
  end

  it 'should die when alive neighbours equals 0' do
    cell = Cell.new(world, 1, 1)
    cell = world.cell_at(1, 1)
    cell.toggle!

    expect(cell.change_state?).to eq(true)
  end

  it 'should stay dead when alive neighbours equals 0' do
    cell = Cell.new(world, 1, 1)
    cell = world.cell_at(1, 1)

    expect(cell.change_state?).to eq(false)
  end

  it 'should die when alive neighbours equals 1' do
    world.cell_at(0, 0).toggle!

    cell = world.cell_at(1, 1)
    cell.toggle!

    expect(cell.change_state?).to eq(true)
  end

  it 'should maintain state when alive neighbours are 2' do
    world.cell_at(0, 0).toggle!
    world.cell_at(0, 1).toggle!

    cell = world.cell_at(1, 1)
    cell.toggle!

    expect(cell.alive?).to eq(true)
    expect(cell.neighbours).to eq(2)
    expect(cell.change_state?).to eq(false)
  end

  it 'should come alive when alive neighbours is 3' do
    world.cell_at(0, 0).toggle!
    world.cell_at(0, 1).toggle!
    world.cell_at(0, 2).toggle!

    cell = world.cell_at(1, 1)

    expect(cell.neighbours).to eq(3)
    expect(cell.change_state?).to eq(true)
  end

  it 'should die when alive neighbours is 4 and state is alive' do
    world.cell_at(0, 0).toggle!
    world.cell_at(0, 1).toggle!
    world.cell_at(0, 2).toggle!
    world.cell_at(1, 0).toggle!

    cell = world.cell_at(1, 1)
    cell.toggle!

    expect(cell.neighbours).to eq(4)
    expect(cell.change_state?).to eq(true)
  end

  it 'should work for a 5x5 grid' do
    world = World.new(5, 5)

    world.cell_at(0, 0).toggle!
    world.cell_at(0, 1).toggle!
    world.cell_at(0, 2).toggle!
    world.cell_at(1, 0).toggle!

    world.cell_at(4, 0).toggle!
    world.cell_at(4, 1).toggle!
    world.cell_at(4, 2).toggle!

    cell = world.cell_at(1, 1)
    cell.toggle!

    expect(cell.neighbours).to eq(4)
    expect(cell.change_state?).to eq(true)
  end

  it 'should work for the top left corner' do
    cell = Cell.new(world, 0, 2)

    expect(cell.change_state?).to eq(false)
  end

  describe 'with a 3x3 grid' do
    it 'should work for the top right corner' do
      cell = Cell.new(world, 2, 2)

      expect(cell.change_state?).to eq(false)
    end

    it 'should work for the bottom left corner' do
      cell = Cell.new(world, 0, 0)

      expect(cell.change_state?).to eq(false)
    end

    it 'should work for the bottom right corner' do
      cell = Cell.new(world, 0, 2)

      expect(cell.change_state?).to eq(false)
    end
  end
end
