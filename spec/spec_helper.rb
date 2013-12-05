require_relative "../game"
require_relative "../player"
require_relative "../ship"

TEST_GAME = <<-JSON
{
  "width": 5,
  "height": 6,
  "game_state": "active",
  "players": [
    {
      "name": "Jacob",
      "ships": [
        {
          "type": "LITTLE",
          "coords": [
            {
              "row": 0,
              "col": 0
            },
            {
              "row": 0,
              "col": 1
            }
          ]
        }
      ],
      "torpedos": [
        {"row": 2, "col": 3}
      ]
    },
    {
      "name": "Simon",
      "ships": [
        {
          "type": "BIG",
          "coords": [
            {
              "row": 2,
              "col": 2
            },
            {
              "row": 3,
              "col": 2
            }
          ]
        },
        {
          "type": "HUGE",
          "coords": [
            {
              "row": 3,
              "col": 3
            },
            {
              "row": 3,
              "col": 4
            }
          ]
        }
      ],
      "torpedos": [
        {"row": 0, "col": 1},
        {"row": 1, "col": 1},
        {"row": 0, "col": 2}
      ]
    }
  ],
  "turn": "Jacob"
}
JSON

TEST_GAME_JSON = JSON.parse(TEST_GAME)

require 'minitest/spec'
require 'minitest/autorun'
