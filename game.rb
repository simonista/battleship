require 'json'
require_relative 'ship'
require_relative 'torpedo'

require_relative 'torpedo'

class Game

  attr_accessor :width, :height, :turn, :game_state, :players

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
    player = Player.new(name)
    player.game = self
    @players << player
    player
  end

  def start
    @players.shuffle!
    @turn = :p1
    @state = 'active'
  end

  def self.from_json(json)
    from_hash(JSON.parse(json))
  end

  def self.from_hash(hash)
    game = Game.new(hash['width'], hash['height'])
    hash['players'].each do |player|
      player = Player.from_hash(player)
      player.game = game
      game.players << player
    end
    game.turn = (hash['turn'] == game.players.first.name ? :p1 : :p2)
    game.game_state = hash['game_state']
    game
  end

  def as_json
    {
      'players' =>  players.map{|p| p.as_json},
      'height'  => height,
      'width'   => width,
      'turn'    => current_player.name,
      'game_state'  => game_state
    }
  end

  def opponent_for(player)
    @players.detect{ |p| p != player }
  end

  def take_turn(player_id, row, col)
    raise unless valid_turn?(player_id)
    raise unless valid_move?(row, col)

    # see if this is a hit
    ships = opponent_for(current_player).ships
    torpedo = Torpedo.new(row, col)
    hit = ships.detect{ |s| s.hit_by_torpedo?(torpedo) }
    torpedo.hit! if hit

    current_player.torpedos << torpedo

    toggle_turn!

    torpedo
  end

  def valid_turn?(player_id)
    player_id == current_player.name
  end

  def valid_move?(row, col)
    in_bounds = row >= 0 && row < height && col >= 0 && col < width
    previous_move = current_player.torpedos.detect do |t|
      t.row == row && t.col == col
    end
    in_bounds && !previous_move
  end

  def toggle_turn!
    @turn = (@turn == :p1 ? :p2 : :p1)
  end

  def current_player
    @turn == :p1 ? @players.first : @players.last
  end
end
