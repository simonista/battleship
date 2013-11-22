class Player
  attr_reader :game, :name, :ships, :torpedos

  def initialize(game, name)
    @game = game
    @name = name
    @ships = []
    @torpedos = []
  end

  def to_s
    name
  end
end
