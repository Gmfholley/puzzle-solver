# frozen_string_literal: true

module Locations
  module Moves
    # Return array of remaining moves in adjacent order
    class Remaining
      attr_reader :moves, :move
      def initialize(moves, move, map)
        @moves = moves
        @move = move
        @map = map
      end

      def perform
        return [] unless moves.length.positive?

        [adjacent_move, *remaining_moves]
      end

      private

      def except_adjacent_move
        moves.reject { |move| move == adjacent_move }
      end

      def remaining_moves
        Remaining.new(except_adjacent_move, adjacent_move, @map).perform
      end

      def adjacent_move
        return @adjacent_move if defined? @adjacent_move

        distance = 1
        while @adjacent_move.nil?
          @adjacent_move = Adjacent.new(moves, move, @map, distance).perform&.first
          distance += 1
        end

        @adjacent_move
      end
    end
  end
end
