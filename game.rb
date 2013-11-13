class Game

  attr_reader :width, :height, :turn, :active, :p1_ships, :p1_torpedos, :p2_ships, :p2_torpedos

  def initialize(width, height)
    @width = width
    @height = height
    @turn = :p1
    @active = true
    @p1_ships = []
    @p1_torpedos = []
    @p2_ships = []
    @p2_torpedos = []
  end

  def add_ship(player, ship)
    ships_for_player(player) << ship
  end

  def add_torpedo(player, torpedo)
    torpedos_for_player(player) << torpedo
  end

  def ships_for_player(player)
    player == :p1 ? @p1_ships : @p2_ships
  end

  def torpedos_for_player(player)
    player == :p1 ? @p1_torpedos : @p2_torpedos
  end

  def display
    puts "Player 1:\n"
    display_player(:p1)
    puts "\nPlayer 2:\n"
    display_player(:p2)
  end

  def display_player(player)
    launched = torpedos_for_player(player)
    received = (player == :p1 ? @p2_torpedos : @p1_torpedos)


    display_side([], launched)
    puts '-' * @width
    display_side(ships_for_player(player), received)
  end

  def display_side(ships, torpedos)
    @height.times do |row|
      @width.times do |col|
        t_hit = torpedos.detect{|t| t.y == row && t.x == col}
        s_hit = ships.detect{|s| s.contains_coord?(row, col)}
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
end
