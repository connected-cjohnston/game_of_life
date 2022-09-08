require './app/cell'

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
  it 'should return dead when cell is dead and no cells are around it' do
    cell = Cell.new(false, build_neighbours(0))

    cell.tick

    expect(cell.alive).to eq(false)
  end

  it 'should return dead when an alive cell has no neighbours' do
    cell = Cell.new(true, build_neighbours(0))

    cell.tick

    expect(cell.alive).to eq(false)
  end

  it 'should die when surrounded by few than 2 neighbours' do
    cell1 = Cell.new(true, [])
    cell = Cell.new(true, [cell1])

    cell.tick

    expect(cell.alive).to eq(false)
  end

  it 'should come alive when surrounded by 3 alive cells' do
    cell = Cell.new(false, build_neighbours(3))

    cell.tick

    expect(cell.alive).to eq(true)
  end

  it 'should die when surrounded by moer than 3 neighbours' do
    cell = Cell.new(true, build_neighbours(4))

    cell.tick

    expect(cell.alive).to eq(false)
  end

  it 'should stay alive when surrounded by 2 neighbours' do
    cell = Cell.new(true, build_neighbours(2))

    cell.tick

    expect(cell.alive).to eq(true)
  end

  it 'should stay dead when surrounded by 2 neighbours' do
    cell = Cell.new(false, build_neighbours(2))

    cell.tick

    expect(cell.alive).to eq(false)
  end

  def build_neighbours(num)
    (0...num).map { Cell.new(true, []) }
  end
end
