# frozen_string_literal: true

# understands the state of a cell
class Cell
  attr_accessor :alive, :neighbours

  def initialize(starting_state, neighbours)
    @alive = starting_state
    @neighbours = neighbours
  end

  def tick
    if lonely?
      @alive = false
    elsif reproduction?
      @alive = true
    elsif over_populated?
      @alive = false
    end
  end

  private

  def lonely?
    alive_neighbours < 2
  end

  def over_populated?
    alive_neighbours >= 4
  end

  def reproduction?
    alive_neighbours == 3
  end

  def alive_neighbours
    neighbours.filter { |n| n.alive == true }.length
  end
end
