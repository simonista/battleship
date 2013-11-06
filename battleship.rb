Game = Struct.new(
  :width,       # int
  :height,      # int
  :turn,        # symbol [:p1,:p2]
  :active?,     # bool
  :p1_ships,    # list of Ship
  :p1_torpedos, # list of Torpedo
  :p2_ships,    # list of Ship
  :p2_torpedos  # list of Torpedo
)

Torpedo = Struct.new(
  :coord, # Coordinate
  :hit?   # bool
)

Coordinate = Struct.new(
  :x, # int
  :y  # int
)

Ship = Struct.new(
  :type,  # ShipType
  :start, # Coordinate
  :end,   # Coordinate
  :alive? # bool
)

ShipType = Struct.new(
  :name,  # symbol [:little]
  :length # int
)


# example coordinates

origin = Coordinate.new(0, 0)
little_ship_start = origin
little_ship_end = Coordinate.new(0,2)

# example ship types

little_ship_type = ShipType.new(:little, 2)

# example ships

p1_little_ship = Ship.new(
  little_ship_type,
  little_ship_start,
  little_ship_end,
  true
)

p2_little_ship = Ship.new(
  little_ship_type,
  little_ship_start,
  little_ship_end,
  true
)

# example games

little_game = Game.new(
  3,
  3,
  :p1,
  true,
  [p1_little_ship],
  [],
  [p2_little_ship],
  []
)

puts little_game
