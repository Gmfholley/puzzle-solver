# frozen_string_literal: true

class CardLocation
  attr_reader :location, :map
  # delegate :x_pos, :y_pos, to: :CardLocationssocation

  def initialize(location, map)
    @location = location
    @map = map
  end

  def neighbor?(direction = :north)
    find_neighbor(direction)
  end

  def neighbor(direction = :north)
    find_neighbor(direction)
  end

  def neighbors
    directions.map do |dir|
      [dir, find_neighbor(dir)]
    end.to_h
  end

  def valid?
    !map.find(x_pos, y_pos).nil?
  end

  def x_pos
    location.x_pos
  end

  def y_pos
    location.y_pos
  end

  private

  def directions
    map.directions
  end

  def find_neighbor(direction)
    map.find(x_pos + direction.x_move, y_pos + direction.y_move)
  end
end
