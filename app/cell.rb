# frozen_string_literal: true

# understands the state of a cell
class Cell
  DEAD = false
  ALIVE = true

  attr_accessor :alive, :neighbours

  def initialize(starting_state, neighbours)
    @alive = starting_state
    @neighbours = neighbours
  end

  def toggle!
    @alive = !@alive
  end

  def alive?
    @alive
  end

  def next_state?
    return alive? if alive_neighbours == 2
    return true if alive_neighbours == 3
    return false if alive_neighbours >= 4
    return false if alive_neighbours <= 1
  end

  private

  def alive_neighbours
    @neighbours.filter { |n| n.alive? == ALIVE }.length
  end
end
