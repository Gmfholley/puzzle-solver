# frozen_string_literal: true

class Map
  attr_accessor :locations
  def initialize(locations = [], directions = [])
    @locations = locations
    @directions = directions
  end

  def valid?
    locations.map(&:name).uniq.length == locations.length
  end

  def find(x, y)
    locations.find{|loc| loc.x == x && loc.y == y }
  end

  def add_occupant(x, y, occupant, orientation = :north)
    location = find(x, y)

    return false if location.nil?
    return false if location.occupied?

    location.occupant = occupant
    occupant.orientation = orientation
    true
  end
end
