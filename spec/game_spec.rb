require_relative "spec_helper"

describe Game do
  let(:game) { Game.from_json(TEST_GAME) }

  it "can be created from json" do
    game.must_be_instance_of Game
  end

  it "can look up active player" do
    game.current_player.must_be_instance_of Player
  end

  describe "#take_turn" do
    it "toggles the active player" do
      current_player = game.turn
      game.take_turn(game.current_player.name, 0, 0)
      assert game.turn != current_player
    end

    it "creates a torpedo" do
      current_player = game.current_player
      game.take_turn(game.current_player.name, 0, 0)
      last_torpedo = current_player.torpedos.last
      assert last_torpedo.row == 0 && last_torpedo.col == 0
    end

    describe "is a hit" do
      it "should mark the torpedo as a hit" do
        torpedo = game.take_turn(game.current_player.name, 2, 2)
        assert torpedo.hit
      end
    end

    describe "is a miss" do
      it "should not mark the torpedo as a hit" do
        torpedo = game.take_turn(game.current_player.name, 0, 0)
        assert !torpedo.hit
      end
    end
  end

  describe "#valid_turn?" do
    it "should be true for current_player" do
      assert game.valid_turn?(game.current_player.name)
    end

    it "should be false for not current_player" do
      assert !game.valid_turn?(game.opponent_for(game.current_player).name)
    end
  end

  describe "#valid_move?" do
    it "should be false if the move is out of bounds" do
      assert !game.valid_move?(game.height, game.width)
      assert !game.valid_move?(-1, -1)
    end

    it "should be false if the move has already been played" do
      torpedo = game.current_player.torpedos.first
      assert !game.valid_move?(torpedo.row, torpedo.col)
    end

    it "should be true otherwise" do
      assert game.valid_move?(0,0)
    end
  end

  describe "imports state" do
    it "imports game state" do
      assert game.players.size == 2
      assert game.height == 6
      assert game.width == 5
      assert game.current_player == game.players.first
    end

    it "imports first player" do
      player = game.players.first
      assert player.game == game
      assert player.name == 'Jacob'

      assert player.ships.size == 1
      ship = player.ships.first
      assert ship.type == :LITTLE
      assert ship.coords == [{ "row" => 0, "col" => 0}, {"row" => 0, "col" => 1}]
      assert ship.alive

      #assert player.torpedos == [{"row" => 2, "col" => 3}]
    end

    it "imports second player" do
      player = game.players.last
      assert player.game == game
      assert player.name == 'Simon'

      assert player.ships.size == 1
      ship = player.ships.first
      assert ship.type == :BIG
      assert ship.coords == [{ "row" => 2, "col" => 2}, {"row" => 3, "col" => 2}]
      assert ship.alive

      #assert player.torpedos == [{"row" => 0, "col" => 1}]
    end
  end


  it "exports game state" do
    #json = game.as_json
    #json['players'].size == 2
    #json['height'] == game.height
    #json['width'] == game.width
    #json['turn'] == game.current_player.name
  end
end
