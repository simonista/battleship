require_relative '../player'
require_relative '../game'
require_relative 'formatter'
require_relative 'input_stream'

module CLI
  class Runner
    def self.start(options={})
      new(options).start
    end

    def initialize(options={})
      @input = options[:input] || CLI::InputStream.default
      @formatter = options[:formatter] || CLI::Formatter.new
    end

    def start
      @game = Game.new(5, 5)

      2.times.map do |i|
        @formatter.prompt_player(i)
        @game.add_player @input.readline
      end

      @game.scaffold
      @game.start

      loop do
        @formatter.display_game(@game, @game.current_player)
        @formatter.prompt_turn(@game.current_player)
        action = @input.readline
        break if action.nil? || action == "quit"
        row, col = action.split(/,/).map(&:strip).map(&:to_i)
        @game.take_turn(row, col)
      end

      @formatter.salutation
    end
  end
end
