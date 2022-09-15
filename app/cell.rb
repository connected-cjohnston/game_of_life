# frozen_string_literal: true

class Cell

  attr_reader :grid, :x, :y

  def initialize(grid, x, y)
    @grid = grid
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
    get_neighbours.select do |c|
      c.alive?
    end.length
  end

  private

  def get_neighbours
    neighbours = []

    if @grid[@x - 1]
      neighbours << @grid[@x - 1][@y - 1] if @grid[@x - 1][@y - 1]
      neighbours << @grid[@x - 1][@y]
      neighbours << @grid[@x - 1][@y + 1] if @grid[@x - 1][@y + 1]
    end

    neighbours << @grid[@x][@y - 1] if @grid[@x][@y - 1]
    neighbours << @grid[@x][@y + 1] if @grid[@x][@y + 1]

    if @grid[@x + 1]
      neighbours << @grid[@x + 1][@y - 1] if @grid[@x + 1][@y - 1]
      neighbours << @grid[@x + 1][@y]
      neighbours << @grid[@x + 1][@y + 1] if @grid[@x + 1][@y + 1]
    end

    neighbours
  end

  def lonely?
    neighbours < 2 && alive?
  end

  def overpopulated?
    neighbours >=4 && alive?
  end

  def reproduction?
    neighbours == 3 && !alive?
  end
end
