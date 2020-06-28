# frozen_string_literal: true

module Locations
  # Returns cards compatible with a location
  PotentialCards = Struct.new(:location, :cards) {
    def perform
      return [] unless location&.unoccupied?

      potential_cards
    end

    private

    def potential_cards
      unique_cards.select { |neighbor| all_sets_include_neighbor?(neighbor) }
    end

    def unique_cards
      potential_neighbor_sets.values.flatten.uniq
    end

    def all_sets_include_neighbor?(neighbor)
      neighbor_directions.all? { |dir| potential_neighbor_sets.fetch(dir).include?(neighbor) }
    end

    def potential_neighbor_sets
      @potential_neighbor_sets ||=
        neighbor_in_each_dir.map { |direction, location|
          [
            direction,
            potential_neighbors(direction, location)
          ]
        }.to_h
    end

    def potential_neighbors(direction, location)
      placed_card = location.occupant
      available_cards.flat_map do |potential_card|
        Direction.all.map { |orientation|
          next potential(potential_card, orientation) if location.unoccupied?

          potential_card.orientation = orientation
          potential(potential_card, orientation) if potential_card.edges_match?(placed_card, direction)
        }.compact
      end
    end

    def potential(card, orientation)
      Cards::Option.new(card, orientation)
    end

    def neighbor_in_each_dir
      location.neighbors.compact
    end

    def neighbor_directions
      neighbor_in_each_dir.keys
    end

    def available_cards
      cards.reject { |card| card.placed? }
    end
  }
end
