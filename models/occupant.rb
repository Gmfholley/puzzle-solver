# frozen_string_literal: true

class Occupant
  attr_reader :location, :orientation

  def initialize(args = {})
    @location = args[:location] # Location
    @orientation = args[:orientation] || Direction.find(:north) # Direction facing ... :north, :south, :east, :west
  end

  def place(location, orientation)
    @location = location
    @orientation = orientation
  end

  def clear
    @location = nil
  end

  def placed?
    !location.nil?
  end

  def unoccupied_sides
    return Direction.all unless placed?

    neighbors.compact.select { |k, v| v.unoccupied? }.keys
  end

  def neighbors
    location.neighbors
  end
end
