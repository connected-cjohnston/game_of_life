# frozen_string_literal: true

require './app/world'

# Defines a cell in game of life
class Cell

  attr_reader :world, :x, :y

  def initialize(world, x, y)
    @world = world
    @x = x
    @y = y
    @state = false
  end

  def alive?
    @state
  end

  def toggle!
    @state = !@state
  end

  def change_state?
    return true if lonely?
    return true if reproduction?
    return true if overpopulated?

    false
  end

  def neighbours
    retrieve_neighbours.select(&:alive?).length
  end

  def to_s
    alive? ? '*' : '-'
  end

  private

  def retrieve_neighbours
    neighbours = []

    neighbours << world.cell_at(@x - 1, @y - 1)
    neighbours << world.cell_at(@x - 1, @y)
    neighbours << world.cell_at(@x - 1, @y + 1)

    neighbours << world.cell_at(@x, @y - 1)
    neighbours << world.cell_at(@x, @y + 1)

    neighbours << world.cell_at(@x + 1, @y - 1)
    neighbours << world.cell_at(@x + 1, @y)
    neighbours << world.cell_at(@x + 1, @y + 1)

    neighbours.compact
  end

  def lonely?
    neighbours < 2 && alive?
  end

  def overpopulated?
    neighbours >= 4 && alive?
  end

  def reproduction?
    neighbours == 3 && !alive?
  end
end
