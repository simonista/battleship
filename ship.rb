SHIP_TYPES = {
  :LITTLE => 2,
  :MED1 => 3,
  :MED2 => 3,
  :BIG => 4,
  :HUGE => 5
}

class Ship
  attr_reader :type, :start_x, :start_y, :end_x, :end_y, :alive

  def initialize(type, start_x, start_y, end_x, end_y)
    @type = type
    @start_x = start_x
    @start_y = start_y
    @end_x = end_x
    @end_y = end_y
    @alive = true
  end

  def contains_coord?(row, col)
    (row == start_y && row == end_y && col >= start_x && col <= end_x) ||
      (row >= start_y && row <= end_y && col == start_x && col == end_x)
  end
end
