require_relative "spec_helper"

describe Torpedo do
  let(:torpedo){Torpedo.from_hash TEST_GAME_JSON["players"][1]["torpedos"][1]}

  it "imports a torpedo" do
    assert torpedo.row == 1
    assert torpedo.col == 1
  end
end