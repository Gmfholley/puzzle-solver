# frozen_string_literal: true

module Locations
  module Moves
    # Return array of Adjacent moves to location
    class Adjacent
      attr_reader :moves, :move, :distance
      def initialize(moves, move, map, distance = 1)
        @moves = moves
        @move = move
        @map = map
        @distance = distance
      end

      def perform
        adjacent_moves
      end

      private

      def num_directions
        @map.directions.length
      end

      def adjacent_moves
        moves.select do |m|
          move_diff(m, move).abs == distance || (num_directions - move_diff(m, move)) == distance
        end
      end

      def move_diff(move1, move2)
        move1.distance_from(move2).abs
      end
    end
  end
end
