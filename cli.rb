require_relative 'player'
require_relative 'game'

def read_input
  if ARGV.empty?
    gets
  else
    val = ARGV.shift
    puts val
    val
  end
end

class CLI
  def self.start
    new.start
  end

  def initialize
    @players = []
  end

  def start
    @players << get_player(1)
    @players << get_player(2)
    @game = Game.scaffold
    @current_player_index = rand(@players.size)
    loop do
      action = prompt_turn
      break if action == "quit"
      execute(action)
      next_player
    end
    print "Goodbye"
  end

  def next_player
    @current_player_index = (@current_player_index + 1) % @players.size
  end

  def get_player(n)
    print "Enter name for player ##{n}: "
    Player.new read_input.chomp
  end

  def current_player
    @players[@current_player_index]
  end

  def prompt_turn
    display
    print "#{current_player}'s turn: "
    read_input.chomp
  end

  def game_player_id(player)
    player == @players.first ? :p1 : :p2
  end

  def display
    display_player(current_player)
  end

  def display_player(player)
    game_id = player == @players.first ? :p1 : :p2
    other_game_id = game_id == :p1 ? :p2 : :p1
    launched = @game.torpedos_for_player(game_id)
    received = @game.torpedos_for_player(other_game_id)

    display_side([], launched)
    puts '-' * @game.width
    display_side(@game.ships_for_player(game_id), received)
  end

  def display_side(ships, torpedos)
    @game.height.times do |row|
      @game.width.times do |col|
        t_hit = torpedos.detect{|t| t.row == row && t.col == col}
        s_hit = ships.detect{|s| s.coords.include?({"row" => row, "col" => col})}
        if t_hit && s_hit
          print 'x'
        elsif t_hit
          print 'o'
        elsif s_hit
          print 's'
        else
          print '.'
        end
      end
      puts
    end
  end

  def execute(action)
    row, col = action.split(/,/).map(&:strip).map(&:to_i)
    @game.take_turn(row, col)
  end
end

CLI.start
