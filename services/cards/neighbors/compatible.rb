# frozen_string_literal: true

module Cards
  module Neighbors
    # Returns Option or nil if it is an option with neighbor in direction
    Compatible = Struct.new(:potential_card, :orientation, :neighbor, :direction) {
      def perform
        return nil unless potential?

        Cards::Option.new(potential_card, orientation)
      end

      def potential?
        unoccupied? || edges_match?
      end

      def edges_match?
        potential_card.orientation = orientation
        potential_card.edges_match?(card, direction)
      end

      def unoccupied?
        neighbor.unoccupied?
      end

      def card
        neighbor.occupant
      end
    }
  end
end
