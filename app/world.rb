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
    @grid[x][y] if @grid[x] && @grid[x][y]
  end

  def next_generation!
    @grid.flatten.filter do |cell|
      cell.change_state?
    end.each do |cell|
      cell.toggle!
    end
  end
end
