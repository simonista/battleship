require_relative 'game'
require_relative 'ship'

Torpedo = Struct.new(
  :x,   # int
  :y,   # int
  :hit? # bool
)


g = Game.new(5,5)
g.add_ship(:p1, Ship.new(:LITTLE, 0, 0, 0, 1))
g.add_ship(:p2, Ship.new(:LITTLE, 1, 2, 2, 2))
g.add_torpedo(:p1, Torpedo.new(2, 3))
g.add_torpedo(:p2, Torpedo.new(0, 1))
g.display
