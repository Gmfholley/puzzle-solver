# frozen_string_literal: true

class Card
  attr_reader :edges
  attr_accessor :location, :orientation

  def initialize(args = {})
    @edges = args[:edges] || []                                 # Edge
    @location = args[:location]                                 # CardLocation
    @orientation = args[:orientation] || Direction.find(:north) # Direction facing ... :north, :south, :east, :west
  end

  def edges_match?(card, direction = Direction.find(:north))
    card_edge = card.opposite_edge_for(direction)
    edge = edge_for(direction)

    edge.matches? card_edge
  end

  def opposite_edge_for(direction)
    opposite_location = direction.opposite

    edges.find{|edge|  edge.relative_location(orientation) == opposite_location }
  end

  def edge_for(direction)
    edges.find{|edge|  edge.relative_location(orientation) == direction }
  end

  def unoccupied_edges
    return edges unless placed?

    unoccupied_sides.map do |dir|
      [dir, edge_for(dir)]
    end.to_h
  end

  def unoccupied_sides
    return Direction.all unless placed?

    neighbors.compact.select{|k, v| v.unoccupied? }.keys
  end

  def neighbors
    location.neighbors
  end

  def placed?
    !location.nil?
  end
end
