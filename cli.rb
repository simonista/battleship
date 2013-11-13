require './player'

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
    dump_boards
    print "#{current_player}'s turn: "
    read_input.chomp
  end

  def dump_boards
  end

  def execute(action)
  end
end

CLI.start
