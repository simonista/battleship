SHIP_TYPES = {
  :LITTLE => 2,
  :MED1 => 3,
  :MED2 => 3,
  :BIG => 4,
  :HUGE => 5
}

class Ship
  attr_reader :type, :coords, :alive

  def initialize(type, coords)
    @type = type
    @coords = coords
    @alive = true
  end

  def self.from_hash(hash)
    Ship.new(hash['type'].to_sym, hash['coords'])
  end

  def hit_by_torpedo?(torpedo)
    hit = coords.detect do |coord|
      coord['row'] == torpedo.row && coord['col'] == torpedo.col
    end
    hit
  end
end
