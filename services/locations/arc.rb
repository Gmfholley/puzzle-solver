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

      # Move in y direction, starting from location1
      y_locations = y_moves(start)

      # Move in x direction, starting from last y move
      continue = y_locations.compact.last
      x_locations = x_moves(continue)

      [start, *y_locations, *x_locations].compact
    end

    private

    def y_moves(from)
      range_of_moves(y_diff).map { |i| move(from.x_pos, i + from.y_pos) }
    end

    def x_moves(from)
      range_of_moves(x_diff).map { |i| move(i + from.x_pos, from.y_pos) }
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
