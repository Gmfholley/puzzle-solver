# frozen_string_literal: true

class Map
  attr_accessor :locations, :directions
  def initialize(locations = [], directions = [])
    @locations = locations
    locations.each{|loc| loc.map = self }
    @directions = directions
  end

  def valid?
    locations.map(&:name).uniq.length == locations.length
  end

  def find(x, y)
    locations.find{|loc| loc.x_pos == x && loc.y_pos == y }
  end

  def clear(location)
    location.occupant.clear
    location.clear
  end

  def place(location, occupant, orientation)
    return false if location.occupied?

    location.place(occupant, orientation)
    true
  end
end
