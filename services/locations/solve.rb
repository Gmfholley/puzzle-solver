# frozen_string_literal: true

module Locations
  # Solve given location as starting point
  class Solve
    include Logging
    attr_reader :location, :cards
    def initialize(location, cards)
      @location = location
      @map = location.map
      @cards = cards
    end

    def perform
      log_start

      @success = try

      log_end

      @success
    end

    private

    def log_start
      logger.info "Moves:  #{moves.length}"
      logger.info "cards.placed.length: #{cards.count(&:placed?)}"
    end

    def log_end
      logger.info "End of Tries for Location: success = #{@success}"
      logger.info { "Map: \n#{@map.to_s.join("\n")}" }
    end

    def try
      Locations::Next.new(0, locations.select(&:unoccupied?), cards).perform
    end

    def locations
      move_sets.flat_map { |move_set|
        move_from = move_set.first
        move_to = move_set.last
        locations_for(move_from.in_direction, move_to.in_direction)
      }.uniq
    end

    def locations_for(from_location, to_location)
      Locations::Arc.new(from_location, to_location).perform
    end

    def move_sets
      Locations::Moves::Sets.new(moves, @map).perform
    end

    def moves
      @moves ||= Locations::Moves::Potential.new(location, cards).perform
    end
  end
end
