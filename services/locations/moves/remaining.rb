# frozen_string_literal: true

module Locations
  # Return array of Adjuacent moves to location
  class AdjacentMoves
    attr_reader :moves, :move
    def initialize(moves, move)
      @moves = moves
      @move = move
    end

    def perform
      adjacent_moves
    end

    private

    def num_directions
      @map.directions.length
    end

    def adjacent_moves
      moves.select { |m| (m.direction.value - move.direction.value).abs == 1 || (num_directions - move.direction.value - m.direction.value).abs == 1 }
    end
  end
end
