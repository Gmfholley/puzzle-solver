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
        puts "moves: #{moves.map(&:potential_neighbors).map(&:length)}"

        moves
      end

      def card
        location.occupant
      end

      private

      def moves
        location.neighbors.compact.map do |direction, location|
          potential_neighbors = ::Cards::Compatible.new(card, cards, direction).perform
          ::Cards::Moves.new(card, direction, potential_neighbors)
        end
      end
    end
  end
end
