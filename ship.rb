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
    Ship.new(nil, hash['coords'])
  end
end
