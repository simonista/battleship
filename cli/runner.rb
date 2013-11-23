require_relative 'formatter'
require_relative 'input_stream'
require_relative 'engine'

module CLI
  class Runner
    def self.start(options={})
      new(options).start
    end

    def initialize(options={})
      @input = options[:input] || CLI::InputStream.default
      @formatter = options[:formatter] || CLI::Formatter.new
      @engine = options[:engine] || CLI::Engine.new
    end

    def start
      @engine.create_game(5, 5)

      2.times.map do |i|
        @formatter.prompt_player(i)
        @engine.add_player(@input.readline)
      end

      @engine.scaffold
      @engine.start

      loop do
        @formatter.display_game(@engine.game_state)
        @formatter.prompt_turn(@engine.current_player)
        action = @input.readline
        break if action.nil? || action == "quit"
        row, col = action.split(/,/).map(&:strip).map(&:to_i)
        @engine.take_turn(row, col)
      end

      @formatter.salutation
    end
  end
end
