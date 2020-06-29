# frozen_string_literal: true

module Locations
  module Moves
    class Potential
      attr_reader :location, :cards

      def initialize(location, cards)
        @location = location
        @cards = cards
      end

      def perform
        moves
      end

      def card
        location.occupant
      end

      private

      def moves
        location.neighbors.compact.map do |direction, location|
          options = ::Cards::Compatible.new(card, cards, direction).perform
          ::Cards::Move.new(card, direction, options)
        end
      end
    end
  end
end
