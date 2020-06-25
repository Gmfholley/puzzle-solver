# frozen_string_literal: true

# A card has been placed in the center location
# Try to fill in the other cards
class FirstTry
  def initialize(center, cards)
    @center = center
    @map = center.map
    @cards = cards
  end

  def perform
    locations = Locations::Arc.new(first_move.to_location, second_move.to_location).perform


    c = next_move(first _move)  
    val = c.neighbors.find { |_dir, location| location == locations[1] }
    dir = val.first
    neighbors = Cards::Compatible.new(c, dir, cards)
    c_moves = Cards::PotentialMoves.new(c, dir, neighbors)
    next_move(c_moves)
  end

  private

  def moves
    @moves ||= Locations::Moves.new(center, cards).perform
  end

  def first_move
    @first_move ||= min_move(moves)
  end

  def second_move
    @second_move ||= min_move(adjacent_moves(first_move))
  end

  def min_move(moves)
    moves.min_by { |move| move.potential_neighbors.length }
  end

  def adjacent_moves(move)
    moves.select { |m| (m.direction.value - move.direction.value).abs == 1 }
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
