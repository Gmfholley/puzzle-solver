# frozen_string_literal: true

module Locations
  module Moves
    # Return array of Adjacent moves to location
    class Minimum
      attr_reader :moves
      def initialize(moves)
        @moves = moves
      end

      def perform
        moves.min_by { |move| move.options.length }
      end
    end
  end
end
