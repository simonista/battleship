require_relative '../player'
require_relative '../game'

module CLI
  # Manages interaction between the CLI and the persistent game state. This
  # default engine simply instantiates a Game that it keeps in memory and to
  # which it proxies interactions. A subclass could instead, for example,
  # request a new game be created on some server and then proxy interactions to
  # that game, all via REST.
  class Engine
    def create_game(rows, cols)
      @game = Game.new(rows, cols)
    end

    def add_player(name)
      @game.add_player(name)
    end

    def scaffold
      @game.scaffold
    end

    def start
      @game.start
    end

    def game_state
      @game.to_hash
    end

    def current_player
      @game.current_player.name
    end

    def take_turn(player_id, row, col)
      @game.take_turn(player_id, row, col)
    end

    def winner
      @game.winner
    end
  end
end
