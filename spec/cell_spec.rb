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
  it 'should toggle a cells state' do
    cell = new_cell(Cell::ALIVE, 0)

    cell.toggle!

    expect(cell.alive?).to eq(Cell::DEAD)
  end

  it 'should return dead when there are 0 neighbours and cell starts alive' do
    cell = new_cell(Cell::ALIVE, 0)
    expect(cell.next_state?).to eq(Cell::DEAD)
  end

  it 'should return dead when there are 1 neighbours' do
    cell = new_cell(Cell::ALIVE, 1)
    expect(cell.next_state?).to eq(Cell::DEAD)
  end

  it 'should stay alive when there are 2 neighbours and cell is alive' do
    cell = new_cell(Cell::ALIVE, 2)
    expect(cell.next_state?).to eq(Cell::ALIVE)
  end

  it 'should stay dead when there are 2 neighbours and cell is dead' do
    cell = new_cell(Cell::DEAD, 2)
    expect(cell.next_state?).to eq(Cell::DEAD)
  end

  it 'should stay alive with 3 alive neighbours' do
    cell = new_cell(Cell::ALIVE, 3)
    expect(cell.next_state?).to eq(Cell::ALIVE)
  end

  it 'should die with 4 alive neighbours' do
    cell = new_cell(Cell::ALIVE, 4)
    expect(cell.next_state?).to eq(Cell::DEAD)
  end

  def new_cell(state, neighbours)
    Cell.new(state, build_neighbours(neighbours))
  end

  def build_neighbours(num)
    (0...num).map { Cell.new(Cell::ALIVE, []) }
  end

  def build_grid(n, m)
    Array.new(n) do |_|
      Array.new(m) { |_| Cell.new(Cell::DEAD) }
    end
  end
end
