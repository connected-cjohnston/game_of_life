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

  let(:grid) {
    [
      [Cell.new([], 0, 2), Cell.new([], 1, 2), Cell.new([], 2, 2)],
      [Cell.new([], 0, 1), Cell.new([], 1, 1), Cell.new([], 2, 1)],
      [Cell.new([], 0, 0), Cell.new([], 1, 0), Cell.new([], 2, 0)],
    ]
  }

  it 'should initialize dead' do
    cell = Cell.new(grid, 1, 1)
    expect(cell.alive?).to eq(false)
  end

  it 'should initialize at the given location' do
    cell = Cell.new(grid, 1, 1)
    expect(cell.x).to eq(1)
    expect(cell.y).to eq(1)
  end

  it 'should initialize with a reference to the grid' do
    cell = Cell.new(grid, 1, 1)
    expect(cell.grid).to eq(grid)
  end

  it 'should toggle its state' do
    cell = Cell.new(grid, 1, 1)
    cell.toggle!
    expect(cell.alive?).to eq(true)
  end

  it 'should return number of alive neighbours' do
    cell = Cell.new(grid, 1, 1)
    expect(cell.neighbours).to eq(0)
  end

  it 'should return number of alive neighbours when there are 2 neighbours' do
    grid[0][0].toggle!
    grid[0][1].toggle!

    cell = Cell.new(grid, 1, 1)
    expect(cell.neighbours).to eq(2)
  end

  it 'should return number of alive neighbours when there are 2 neighbours' do
    grid[0][0].toggle!
    grid[0][1].toggle!

    cell = Cell.new(grid, 1, 1)
    grid[1][1] = cell
    cell.toggle!

    expect(cell.neighbours).to eq(2)
  end

  it 'should die when alive neighbours equals 0' do
    cell = Cell.new(grid, 1, 1)
    grid[1][1] = cell
    cell.toggle!

    expect(cell.change_state?).to eq(true)
  end

  it 'should stay dead when alive neighbours equals 0' do
    cell = Cell.new(grid, 1, 1)
    grid[1][1] = cell

    expect(cell.change_state?).to eq(false)
  end

  it 'should die when alive neighbours equals 1' do
    grid[0][0].toggle!

    cell = Cell.new(grid, 1, 1)
    grid[1][1] = cell
    cell.toggle!

    expect(cell.change_state?).to eq(true)
  end

  it 'should maintain state when alive neighbours are 2' do
    grid[0][0].toggle!
    grid[0][1].toggle!

    cell = Cell.new(grid, 1, 1)
    grid[1][1] = cell
    cell.toggle!

    expect(cell.alive?).to eq(true)
    expect(cell.neighbours).to eq(2)
    expect(cell.change_state?).to eq(false)
  end

  it 'should come alive when alive neighbours is 3' do
    grid[0][0].toggle!
    grid[0][1].toggle!
    grid[0][2].toggle!

    cell = Cell.new(grid, 1, 1)
    grid[1][1] = cell

    expect(cell.neighbours).to eq(3)
    expect(cell.change_state?).to eq(true)
  end

  it 'should die when alive neighbours is 4 and state is alive' do
    grid[0][0].toggle!
    grid[0][1].toggle!
    grid[0][2].toggle!
    grid[1][0].toggle!

    cell = Cell.new(grid, 1, 1)
    grid[1][1] = cell
    cell.toggle!

    expect(cell.neighbours).to eq(4)
    expect(cell.change_state?).to eq(true)
  end

  it 'should work for a 5x5 grid' do
    grid = [
      [Cell.new([], 0, 4), Cell.new([], 1, 4), Cell.new([], 2, 4), Cell.new([], 3, 4), Cell.new([], 4, 4)],
      [Cell.new([], 0, 3), Cell.new([], 1, 3), Cell.new([], 2, 3), Cell.new([], 3, 3), Cell.new([], 4, 3)],
      [Cell.new([], 0, 2), Cell.new([], 1, 2), Cell.new([], 2, 2), Cell.new([], 3, 2), Cell.new([], 4, 2)],
      [Cell.new([], 0, 1), Cell.new([], 1, 1), Cell.new([], 2, 1), Cell.new([], 3, 1), Cell.new([], 4, 1)],
      [Cell.new([], 0, 0), Cell.new([], 1, 0), Cell.new([], 2, 0), Cell.new([], 3, 0), Cell.new([], 4, 0)],
    ]

    grid[0][0].toggle!
    grid[0][1].toggle!
    grid[0][2].toggle!
    grid[1][0].toggle!

    grid[4][0].toggle!
    grid[4][1].toggle!
    grid[4][2].toggle!

    cell = Cell.new(grid, 1, 1)
    cell.toggle!

    expect(cell.neighbours).to eq(4)
    expect(cell.change_state?).to eq(true)
  end

  it 'should work for the top left corner' do
    cell = Cell.new(grid, 0, 2)

    expect(cell.change_state?).to eq(false)
  end

  describe 'with a 3x3 grid' do
    it 'should work for the top right corner' do
      cell = Cell.new(grid, 2, 2)

      expect(cell.change_state?).to eq(false)
    end

    it 'should work for the bottom left corner' do
      cell = Cell.new(grid, 0, 0)

      expect(cell.change_state?).to eq(false)
    end

    it 'should work for the bottom right corner' do
      cell = Cell.new(grid, 0, 2)

      expect(cell.change_state?).to eq(false)
    end
  end

  it 'should accept the world' do
    world = World.new(3, 3)

    cell = Cell.new(world, 1, 1)
  end
end
