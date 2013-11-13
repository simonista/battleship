class Torpedo
  attr_reader :row, :col, :hit

  def initialize(row, col)
    @row = row
    @col = col
    @hit = false
  end

  def hit!
    @hit = true
  end
end
