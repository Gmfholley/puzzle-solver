# frozen_string_literal: true

module Locations
  module Neighbors
    # Returns cards compatible with having a neighbor in direction
    # From the perspective of a presumably unoccupied location looking at its possibly occupied neighbors
    Compatible = Struct.new(:neighbor, :direction, :cards) {
      def perform
        available_cards.flat_map do |potential_card|
          orientations.map { |orientation|
            ::Cards::Neighbors::Compatible.new(potential_card, orientation, neighbor, direction).perform
          }.compact
        end
      end

      def orientations
        neighbor.map.directions
      end

      def available_cards
        cards.reject { |card| card.placed? }
      end
    }
  end
end
