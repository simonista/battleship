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
          torpedo = torpedos.detect{|t| t['row'] == row && t['col'] == col}
          ship = ships.detect{|s| s['coords'].include?({"row" => row, "col" => col})}
          hit = (torpedo && torpedo['hit']) || (torpedo && ship)
          if hit
            print 'x'
          elsif torpedo
            print 'o'
          elsif ship
            print 's'
          else
            print '.'
          end
        end
        puts
      end
    end

    def salutation(winner=nil)
      puts
      puts winner ? "#{winner} WON!" : "Goodbye"
    end
  end
end
