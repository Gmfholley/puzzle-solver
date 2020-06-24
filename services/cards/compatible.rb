# frozen_string_literal: true

module Cards
  # Returns cards compatible with the card in the direction
  Compatible = Struct.new(:card, :cards, :direction) {
    def perform
      return [] unless card.placed?

      potential_neighbors
    end

    private

    def potential_neighbors
      available_cards.flat_map do |potential_card|
        Direction.all.select do |potential_direction|
          potential_card.orientation = potential_direction
          PotentialNeighbor.new(potential_card, potential_direction) if card.edges_match?(potential_card, direction)
        end
      end
    end

    def available_cards
      cards.reject { |card| card.placed? }
    end
  }
end
