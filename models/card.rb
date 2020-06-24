# frozen_string_literal: true

require_relative "occupant"

class Card < Occupant
  attr_reader :edges
  # attr_reader :location, :orientation from Occupant

  def initialize(args = {})
    @edges = args[:edges] || [] # Edge
    super
  end

  # :clear, :neighbors, :unoccupied_sides are methods from Occupant

  def edges_match?(card, direction = Direction.find(:north))
    card_edge = card.edge_opposite(direction)
    edge = edge_on(direction)

    edge.matches? card_edge
  end

  def edge_opposite(direction)
    opposite_location = direction.opposite

    edges.find { |edge| edge.relative_location(orientation) == opposite_location }
  end

  def edge_on(direction)
    edges.find { |edge| edge.relative_location(orientation) == direction }
  end

  def unoccupied_edges
    return edges unless placed?

    unoccupied_sides.map { |dir|
      [dir, edge_on(dir)]
    }.to_h
  end

  def ==(other_obj)
    Cards::Equal.new(self, other_obj).perform
  end

  def to_s
    [""]
  end
end
