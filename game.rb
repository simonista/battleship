require 'json'
require_relative 'ship'
require_relative 'torpedo'

require_relative 'torpedo'

class Game

  attr_accessor :width, :height, :turn, :active

  def scaffold
    add_ship(@players.first, Ship.new(:LITTLE, [{"row" => 0, "col" => 0}, {"row" => 0, "col" => 1}]))
    add_ship(@players.last, Ship.new(:LITTLE, [{"row" => 1, "col" => 2}, {"row" => 2, "col" => 2}]))
    add_torpedo(@players.first, Torpedo.new(2, 3))
    add_torpedo(@players.last, Torpedo.new(0, 1))
  end

  def initialize(width, height)
    @width = width
    @height = height
    @players = []
  end

  def add_player(name)
    player = Player.new(self, name)
    @players << player
    player
  end

  def start
    @players.shuffle!
    @turn = :p1
    @active = true
  end

  def self.from_json(json)
    from_hash(JSON.parse(json))
  end

  def self.from_hash(hash)
    game = Game.new(hash['width'], hash['height'])
    p1 = game.add_player(hash['p1_name'])
    p2 = game.add_player(hash['p2_name'])
    p1.ships = hash['p1_ships'].map{|s| Ship.from_hash(s)}
    p2.ships = hash['p2_ships'].map{|s| Ship.from_hash(s)}
    game
  end

  def opponent_for_player(player)
    @players.detect{ |p| p != player }
  end

  def take_turn(row, col)
    # see if this is a hit
    ships = opponent_for_player(current_player).ships
    torpedo = Torpedo.new(row, col)
    hit = ships.detect{ |s| s.hit_by_torpedo?(torpedo) }
    torpedo.hit! if hit

    add_torpedo(current_player, torpedo)

    toggle_turn!

    torpedo
  end

  def active_player
    turn
  end

  def toggle_turn!
    @turn = (@turn == :p1 ? :p2 : :p1)
  end

  def current_player
    @turn == :p1 ? @players.first : @players.last
  end

  def add_ship(player, ship)
    player.ships << ship
  end

  def add_torpedo(player, torpedo)
    player.torpedos << torpedo
  end

  def p1_ships
    @players.first.ships
  end

  def torpedos_for(player)
    player.torpedos
  end

  def ships_for_player(player)
    player.ships
  end

  def p1_torpedos
    @players.first.torpedos
  end

  def p2_ships
    @players.last.ships
  end

  def p2_torpedos
    @players.last.torpedos
  end
end
