require 'json'
require_relative 'ship'
require_relative 'torpedo'

require_relative 'torpedo'

class Game

  attr_accessor :width, :height, :turn, :active

  def scaffold
    @players.first.ships << Ship.new(:LITTLE, [{"row" => 0, "col" => 0}, {"row" => 0, "col" => 1}])
    @players.last.ships << Ship.new(:LITTLE, [{"row" => 1, "col" => 2}, {"row" => 2, "col" => 2}])
    @players.first.torpedos << Torpedo.new(2, 3)
    @players.last.torpedos << Torpedo.new(0, 1)
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
    hash['players'].each do |player|
      player = Player.from_hash(player)
      player.game = self
      @players << player
    end
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

    current_player.torpedos << torpedo

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
end
