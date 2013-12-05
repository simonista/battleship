require_relative "spec_helper"

describe Player do
  let(:player){Player.from_hash TEST_GAME_JSON["players"][1]}

  it "imports a player" do
    assert player.name == 'Simon',      "has name 'Simon'"
    assert player.ships.size == 2,      "has two ships"
    assert player.game == nil,          "has no game"
    assert player.torpedos.size == 3,   "has 3 torpedos"
  end
end