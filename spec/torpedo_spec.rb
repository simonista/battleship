require_relative "spec_helper"

describe Torpedo do
  let(:json){ read_game_json('client_active_game') }

  it "imports a torpedo" do
    torpedo = Torpedo.from_hash(json["players"][0]["torpedos"][0])
    assert torpedo.row == 3
    assert torpedo.col == 2
  end

  it "imports a torpedo with a hit" do
    torpedo = Torpedo.from_hash(json["players"][0]["torpedos"][0])
    assert torpedo.hit == true
  end

  it "imports a torpedo with a miss" do
    torpedo = Torpedo.from_hash(json["players"][0]["torpedos"][1])
    assert torpedo.hit == false
  end

  it "defaults a torpedo to miss" do
    torpedo = Torpedo.from_hash(json["players"][0]["torpedos"][2])
    assert torpedo.hit == false
  end
end