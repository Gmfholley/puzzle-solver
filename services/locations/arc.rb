# frozen_string_literal: true

module Locations
  # Returns locations in order between the two, from 1 to 2
  # Note, if the center  of your maps is not 0, 0, the math in here is not right
  class Arc
    attr_reader :location1, :location2, :map

    def initialize(location1, location2)
      @location1 = location1
      @location2 = location2
      @map = location1.map
    end

    def perform
      start = location1

      locations = path.flat_map { |dir, diff|
        dir_locations = move_in(start, diff, dir)
        start = dir_locations.compact.last
        dir_locations
      }

      [location1, *locations].compact
    end

    private

    def move_in(from, to, dir = :x)
      range_of_moves(to).map { |i|
        xd = dir == :x ? i : 0
        yd = dir == :y ? i : 0
        move(from.x_pos + xd, from.y_pos + yd)
      }
    end

    def path
      {x: x_diff, y: y_diff}.sort_by { |dir, diff|
        (diff + location1.send("#{dir}_pos")).abs
      }.reverse.to_h
    end

    def range_of_moves(up_to)
      return (1..up_to).to_a if up_to.positive?
      return [] if up_to.zero?

      (up_to..-1).to_a.reverse
    end

    def move(x, y)
      map.find(x, y)
    end

    def positive_or_negative_one(num)
      num < 0 ? -1 : 1
    end

    def x_diff
      location2.x_pos - location1.x_pos
    end

    def y_diff
      location2.y_pos - location1.y_pos
    end
  end
end
