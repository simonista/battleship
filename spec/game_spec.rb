require_relative "spec_helper"

require 'minitest/spec'
require 'minitest/autorun'

describe Game do
  let(:game) {Game.from_json(TEST_GAME)}
  before do
    game.start
  end

  it "can be created from json" do
    game.must_be_instance_of Game
  end

  it "can look up active player" do
    game.current_player.must_be_instance_of Player
  end

  describe "#take_turn" do
    it "toggles the active player" do
      current_player = game.turn
      game.take_turn(0,0)
      assert game.turn != current_player
    end

    it "creates a torpedo" do
      current_player = game.turn
      game.take_turn(0,0)
      assert game.turn != current_player
    end
  end
end
