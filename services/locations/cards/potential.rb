# frozen_string_literal: true

module Locations
  module Cards
    # Returns cards compatible with a location
    Potential = Struct.new(:location, :cards) {
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
        Locations::Neighbors::Compatible.new(location, direction, cards).perform
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
end
