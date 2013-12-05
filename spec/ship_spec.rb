require_relative "spec_helper"

describe Ship do
  let(:ship){Ship.from_hash TEST_GAME_JSON["players"][1]["ships"][1]}

  it "imports a ship" do
    ship.type == "HUGE"
    assert ship.type == :HUGE
    assert ship.coords == [{ "row" => 3, "col" => 3}, {"row" => 3, "col" => 4}]
    assert ship.alive == true
  end
end