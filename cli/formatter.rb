module CLI
  class Formatter
    def prompt_player(n)
      print "Enter name for player ##{n}: "
    end

    def prompt_turn(player)
      print "#{player}'s turn: "
    end

    def display_game(game, player)
      opponent = game.opponent_for_player(player)
      display_side(game, [], player.torpedos)
      puts '-' * game.width
      display_side(game, player.ships, opponent.torpedos)
    end

    def display_side(game, ships, torpedos)
      game.height.times do |row|
        game.width.times do |col|
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

    def salutation
      puts
      puts "Goodbye"
    end
  end
end
