require_relative "../game"
require_relative "../player"
require_relative "../ship"

TEST_GAME = <<-JSON
{
  "width": 5,
  "height": 5,
  "turn": "p1",
  "active": true,
  "p1_ships": [
    {
      "coords": [
        {
          "row": 0,
          "col": 0
        },
        {
          "row": 0,
          "col": 1
        }
      ],
      "alive": true
    }
  ],
  "p1_torpedos": [],
  "p2_ships": [
    {
      "coords": [
        {
          "row": 2,
          "col": 2
        },
        {
          "row": 3,
          "col": 2
        }
      ],
      "alive": true
    }
  ],
  "p2_torpedos": []
}
JSON