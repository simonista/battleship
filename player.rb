class Player
  attr_accessor :game, :name, :ships, :torpedos

  def initialize(game, name)
    @game = game
    @name = name
    @ships = []
    @torpedos = []
  end

  def to_s
    name
  end

  def self.from_hash(hash)
    player = Player.new(nil, hash['name'])
    player.ships = hash['ships'].map{|s| Ship.from_hash(s)}
    player.torpedos = hash['torpedos'].map{|t| Torpedo.from_hash(t)}
    player
  end
end
