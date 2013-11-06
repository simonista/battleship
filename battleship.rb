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
  :x,   # int
  :y,   # int
  :hit? # bool
)

Ship = Struct.new(
  :type,    # symbol
  :start_x, # int
  :start_y, # int
  :end_x,   # int
  :end_y,   # int
  :alive?   # bool
)

SHIP_TYPES = {
  :LITTLE => 2
}

# example ships

p1_little_ship = Ship.new(:LITTLE, 0, 0, 0, 1, true)
p2_little_ship = Ship.new(:LITTLE, 0, 0, 0, 1, true)

# example torpedos

p1_torpedo_1 = Torpedo.new(0, 2, false)

# example games

little_game = Game.new(
  3,
  3,
  :p2,
  true,
  [p1_little_ship],
  [p1_torpedo_1],
  [p2_little_ship],
  []
)

puts little_game
