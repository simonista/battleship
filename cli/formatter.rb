module CLI
  class Formatter
    def prompt_player(n)
      print "Enter name for player ##{n}: "
    end

    def prompt_turn(player)
      print "#{player}'s turn: "
    end

    def display_game(game_state)
      players = game_state['players']
      players = players.reverse unless players.first['name'] == game_state['turn']
      player, opponent = players
      display_side(game_state, [], player['torpedos'])
      puts '-' * game_state['width']
      display_side(game_state, player['ships'], opponent['torpedos'])
    end

    def display_side(game_state, ships, torpedos)
      game_state['height'].times do |row|
        game_state['width'].times do |col|
          t_hit = torpedos.detect{|t| t['row'] == row && t['col'] == col}
          s_hit = ships.detect{|s| s['coords'].include?({"row" => row, "col" => col})}
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

    def salutation
      puts
      puts "Goodbye"
    end
  end
end
