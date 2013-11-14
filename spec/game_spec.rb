require_relative "spec_helper"

require 'minitest/spec'
require 'minitest/autorun'

describe Game do
  it "can be created from json" do
    game = Game.from_json(TEST_GAME)
    game.must_be_instance_of Game
  end
end