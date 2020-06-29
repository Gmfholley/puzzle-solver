# frozen_string_literal: true

module Locations
  # Return array of Locations, in order they will be searched
  class Set
    attr_reader :center, :cards
    def initialize(center, cards)
      @center = center
      @map = center.map
      @cards = @cards
    end

    def perform
      locations
    end

    private

    def locations
      [
        *locations_for(first_move.in_direction, second_move.in_direction),
        *remaining_move_sets.flat_map { |move_set| locations_for(move_set.first.in_direction, move_set[1].in_direction) }
      ].uniq
    end

    def locations_for(from_location, to_location)
      Locations::Arc.new(from_location, to_location).perform
    end

    def moves
      @moves ||= Locations::Moves.new(center, cards).perform
    end

    def first_move
      @first_move ||= min_move(moves)
    end

    def second_move
      @second_move ||= min_move(adjacent_moves(first_move, moves))
    end

    def min_move(moves)
      moves.min_by { |move| move.options.length }
    end

    def num_directions
      @map.directions.length
    end

    def adjacent_moves(move, moves)
      moves.select { |m| (m.direction.value - move.direction.value).abs == 1 || (num_directions - move.direction.value - m.direction.value).abs == 1 }
    end

    def remaining_move_sets
      [
        remaining_first_set,
        *remaining_moves.map.with_index { |move, i| [move, remaining_moves[i + 1]] }[0...-1],
        last_set_to_first
      ]
    end

    def remaining_first_set
      [adjacent_moves(remaining_moves.first, [first_move, second_move]).first, remaining_moves.first]
    end

    def last_set_to_first
      [remaining_moves.last, first_move]
    end

    def descending_order?
      first_move_value = first_move.direction.value.zero? ? @map.directions.length : first_move.direction.value
      second_move_value = second_move.direction.value.zero? ? @map.directions.length : second_move.direction.value

      (first_move_value - second_move_value).positive?
    end

    def remaining_moves
      @remaining_moves ||= moves.reject { |move| [first_move, second_move].include? move }.sort_by { |move| move.direction.value * (descending_order? ? 1 : -1) }
    end
  end
end
