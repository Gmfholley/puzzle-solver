# frozen_string_literal: true

module Locations
  module Moves
    # Return array of arrays of moves (from, to), in all directions
    # In order of most restricted then to next most restricted adjacent move, then to next adjacent move
    class Sets
      attr_reader :moves
      def initialize(moves, map)
        @moves = moves
        @map = map
      end

      def perform
        ordered_moves.map.with_index { |move, i|
          [move, ordered_moves[i + 1] || first_move]
        }
      end

      private

      def ordered_moves
        [
          first_move,
          second_move,
          *remaining_moves
        ]
      end

      def first_move
        @first_move ||= min_move(moves)
      end

      def second_move
        @second_move ||= min_move(adjacent_moves(first_move, moves))
      end

      def exceept_first_second_moves
        moves.reject { |m| m == first_move || m == second_move }
      end

      def remaining_moves
        @remaining_moves ||= Locations::Moves::Remaining.new(exceept_first_second_moves, second_move, @map).perform
      end

      def min_move(moves)
        Locations::Moves::Minimum.new(moves).perform
      end

      def adjacent_moves(move, moves)
        Locations::Moves::Adjacent.new(moves, move, @map).perform
      end
    end
  end
end
