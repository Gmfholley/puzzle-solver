# frozen_string_literal: true

class Solver
  attr_accessor :card_index
  attr_reader :cards, :map

  def initialize(map, cards)
    @map = map
    @cards = Cards::Ranker.new(cards).perform
    @card_index = 0
  end

  def perform
    @card_index = 0

    while (unsolved? || unfinished?) do
      place_card_in_center

      solve_for_card

      card_index += 1
    end
  end

  private

  def center
    @center ||= Locations::Center.new(map).perform
  end

  def unsolved?
    cards.any?(&:unplaced?)
  end

  def unfinished?
    card_index >= cards.length
  end

  def card
    cards[card_index]
  end

  def place_card_in_center
    center.place(card, card.orientation)
  end

  def solve_for_card
    loc = center
    moves = loc.neighbors.compact.map do |direction, location|
      potential_neighbors = Cards::Compatible.new(card, cards, direction).perform
      Cards::PotentialMoves.new(card, direction, potential_neighbors)
    end

    first_move = moves.min_by { |move| move.potential_neighbors.length }
    adjacent_moves = moves.select { |move| (move.direction.value - first_move.direction.value).abs == 1 }
    second_move = adjacent_moves.min_by { |move| move.potential_neighbors.length }

    locations = Locations::Arc.new(first_move.to_location, second_move.to_location).perform
    binding.pry
    c = next_move(first_move)
    val = c.neighbors.find { |_dir, location| location == locations[1] }
    dir = val.first
    neighbors = Cards::Compatible.new(c, dir, cards)
    c_moves = Cards::PotentialMoves.new(c, dir, neighbors)
    next_move(c_moves)

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
