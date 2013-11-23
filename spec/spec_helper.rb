require_relative "../game"
require_relative "../player"
require_relative "../ship"

TEST_GAME = <<-JSON
{
  "width": 5,
  "height": 6,
  "active": true,
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
          ],
          "alive": true
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
          ],
          "alive": true
        }
      ],
      "torpedos": [
        {"row": 0, "col": 1}
      ]
    }
  ],
  "turn": "Jacob"
}
JSON

require 'minitest/spec'
require 'minitest/autorun'
