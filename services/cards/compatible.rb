# frozen_string_literal: true

module Cards
  # Returns cards compatible with card in the direction
  # From the perspective of the occupied location (card's location) looking out at its neighbors
  Compatible = Struct.new(:card, :cards, :direction) {
    def perform
      return [] unless card.placed?

      potential_neighbors
    end

    private

    def potential_neighbors
      available_cards.flat_map do |potential_card|
        orientations.map { |orientation|
          Cards::Neighbors::Compatible.new(potential_card, orientation, card.location, direction.opposite).perform
        }.compact
      end
    end

    def orientations
      card.location.map.directions
    end

    def available_cards
      cards.reject { |card| card.placed? }
    end
  }
end
