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
    @grid.flatten.filter(&:change_state?).each(&:toggle!)
  end

  def to_s
    @grid.map do |row|
      row.map(&:to_s).join('')
    end.join(',')
  end
end
