class Player
  attr_accessor :game, :name, :ships, :torpedos

  def initialize(name)
    @name = name
    @ships = []
    @torpedos = []
  end

  def to_s
    name
  end

  def self.from_hash(hash)
    player = Player.new(hash['name'])
    player.ships = hash['ships'].map{|s| Ship.from_hash(s)}
    player.torpedos = hash['torpedos'].map{|t| Torpedo.from_hash(t)}
    player
  end

  def to_hash
    {
      'name' => @name,
      'ships' => @ships.map(&:to_hash),
      'torpedos' => @torpedos.map(&:to_hash)
    }
  end
end
