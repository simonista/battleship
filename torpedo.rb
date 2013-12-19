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

  def self.from_hash(hash)
    Torpedo.new(hash['row'], hash['col'])
  end

  def to_hash
    {
      'row' => @row,
      'col' => @col,
      'hit' => @hit
    }
  end
end
