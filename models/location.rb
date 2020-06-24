# frozen_string)_literal: true

class Location
  attr_reader :name, :x_pos, :y_pos, :occupant
  attr_accessor :map

  def initialize(args = {})
    @name = args[:name]
    @x_pos = args[:x]
    @y_pos = args[:y]
    @map = args[:map]
  end

  def occupied?
    !occupant.nil?
  end

  def place(occupant, orientation)
    occupant.place(self, orientation)
    @occupant = occupant
  end

  def clear
    occupant.clear
    @occupant = nil
  end

  def neighbor?(direction = Direction.north)
    find_neighbor(direction)
  end

  def neighbor(direction = Direction.north)
    find_neighbor(direction)
  end

  def neighbors
    directions.map { |dir|
      [dir, find_neighbor(dir)]
    }.to_h
  end

  def valid?
    !map.find(x_pos, y_pos).nil?
  end

  private

  def directions
    map.directions
  end

  def find_neighbor(direction)
    map.find(x_pos + direction.x_move, y_pos + direction.y_move)
  end
end
