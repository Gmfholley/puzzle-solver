# frozen_string_literal: true

class Map
  attr_accessor :locations, :directions, :ever_placed
  def initialize(locations = [], directions = [])
    @locations = locations
    locations.each { |loc| loc.map = self }
    @directions = directions
    @ever_placed = 0
  end

  def valid?
    locations.map(&:name).uniq.length == locations.length
  end

  def find(x, y)
    locations.find { |loc| loc.x_pos == x && loc.y_pos == y }
  end

  def clear(location)
    location.clear
  end

  def place(location, occupant, orientation)
    return false if location.occupied?

    location.place(occupant, orientation)
    true
  end

  def to_s
    locations.sort_by(&:x_pos)
      .reverse
      .group_by { |loc| loc.x_pos }
      .map do |row, locs|
        sets_of_rows = locs.sort_by { |loc| loc.y_pos }.map { |loc| loc.to_s }
        num_rows = sets_of_rows.first.length

        (0...num_rows).to_a.map { |i|
          sets_of_rows.map { |loc_row| loc_row[i] }.join(" | ")
        }.join("\n")
      end
  end
end
