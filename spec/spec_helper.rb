require_relative "../game"
require_relative "../player"
require_relative "../ship"

def read_game(file)
  File.read("#{File.dirname(__FILE__)}/resources/#{file}.json")
end

def read_game_json(file)
  JSON.parse(read_game(file))
end

TEST_GAME = read_game('server_active_game')
TEST_GAME_JSON = read_game_json('server_active_game')

require 'minitest/spec'
require 'minitest/autorun'
