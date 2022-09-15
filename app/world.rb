class World

  def initialize(height, width)
    @grid = []
    height.times do |x|
      @grid << []
      width.times do |y|
        @grid[x] << Cell.new(self, x, y)
      end
    end
  end

  def height
    @grid.length
  end

  def width
    @grid[0].length
  end

  def cell_at(x, y)
    @grid[x][y] if @grid[x]
  end

  def next_generation!

  end
end
