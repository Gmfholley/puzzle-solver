# frozen_string_literal: true

# Having placed a card
class Try
  def initialize(location1, location2, cards)
    @location1 = location1
    @location2 = location2
    @cards = cards
  end

  def perform

    c = next_move(first _move)  
    val = c.neighbors.find { |_dir, location| location == locations[1] }
    dir = val.first
    neighbors = Cards::Compatible.new(c, dir, cards)
    c_moves = Cards::PotentialMoves.new(c, dir, neighbors)
    next_move(c_moves)
  end

  private

  def moves(location)
    Locations::Moves.new(location, czards).perform
  end

  def locations
    @arc ||= Locations::Arc.new(first_move.to_location, second_move.to_location).perform
  end

  def next_move(move)
    return false if move.untried_neighbors.none?

    neighbor = move.untried_neighbors.first
    neighbor.mark
    location = move.to_location
    location.place(neighbor.card, neighbor.orientation)
    return neighbor.card
  end
end
