require 'json'
require_relative 'ship'
require_relative 'torpedo'

require_relative 'torpedo'

TEST = <<-JSON
{
  'width': 5,
  'height': 5,
  'turn': 'p1',
  'active': true,
  'p1_ships': [
    {
      'coords': [
        {
          'row': 0,
          'col': 0
        },
        {
          'row': 0,
          'col': 1
        }
      ],
      'alive': true
    }
  ],
  'p1_torpedos': [],
  'p2_ships': [
    {
      'coords': [
        {
          'row': 2,
          'col': 2
        },
        {
          'row': 3,
          'col': 2
        }
      ],
      'alive': true
    }
  ],
  'p2_torpedos': [],
}
JSON

class Game

  attr_reader :width, :height, :turn, :active, :p1_ships, :p1_torpedos, :p2_ships, :p2_torpedos

  def self.scaffold
    g = Game.new(5,5)
    g.add_ship(:p1, Ship.new(:LITTLE, [{"row" => 0, "col" => 0}, {"row" => 0, "col" => 1}]))
    g.add_ship(:p2, Ship.new(:LITTLE, [{"row" => 1, "col" => 2}, {"row" => 2, "col" => 2}]))
    g.add_torpedo(:p1, Torpedo.new(2, 3))
    g.add_torpedo(:p2, Torpedo.new(0, 1))
    g
  end

  def initialize(width, height)
    @width = width
    @height = height
    @turn = :p1
    @active = true
    @p1_ships = []
    @p1_torpedos = []
    @p2_ships = []
    @p2_torpedos = []
  end

  def self.from_json(json)
    from_hash(JSON.parse(json))
  end

  def self.from_hash(hash)
    game = Game.new(hash['width'], hash['height'])
    game.p1_ships = hash['p1_ships'].map{|s| Ship.from_hash(s)}
    game.p2_ships = hash['p2_ships'].map{|s| Ship.from_hash(s)}
    game
  end

  def take_turn(row, col)
    # see if this is a hit
    ships = opponent_ships_for_player(@turn)
    torpedo = Torpedo.new(row, col)
    hit = ships.detect{ |s| s.hit_by_torpedo?(torpedo) }

    add_torpedo(@turn, torpedo)

    toggle_turn!

    torpedo
  end

  def toggle_turn!
    @turn = (@turn == :p1 ? :p2 : p1)
  end

  def add_ship(player, ship)
    ships_for_player(player) << ship
  end

  def add_torpedo(player, torpedo)
    torpedos_for_player(player) << torpedo
  end

  def ships_for_player(player)
    player == :p1 ? @p1_ships : @p2_ships
  end

  def opponent_ships_for_player(player)
    player == :p1 ? @p2_ships : @p1_ships
  end

  def torpedos_for_player(player)
    player == :p1 ? @p1_torpedos : @p2_torpedos
  end
end
