# frozen_string_literal: true

module Locations
  # Recursively places next location given cards
  class Next
    include Logging
    attr_reader :location_index, :locations, :cards

    def initialize(location_index, locations, cards)
      @location_index = location_index
      @locations = locations
      @cards = cards
    end

    def perform
      return false unless location

      make_moves

      return true if all_placed?

      clear_location
      false
    end

    private

    def clear_location
      location.clear
    end

    def all_placed?
      locations.all?(&:occupied?)
    end

    def make_moves
      return next_location if location.occupied?

      log_info

      while next_moves.any?(&:unmarked?) && locations.any?(&:unoccupied?)
        clear_location
        move(next_moves.shift)
        next_location
      end
    end

    def log_info
      logger.info "Unmarked moves to #{location.name}: #{next_moves.count(&:unmarked?)}"
      logger.info "Location_index: #{location_index}"
      logger.info "Num_locations: #{locations.length}"
      logger.info "Cards placed: #{cards.count(&:placed?)}"
      logger.info { "Map: \n#{location.map.to_s.join("\n")}" }
    end

    def location
      locations[location_index]
    end

    def next_moves
      @next_moves ||= Locations::Cards::Potential.new(location, cards).perform
    end

    def next_location
      Locations::Next.new(location_index + 1, locations, cards).perform
    end

    def move(move)
      move.to(location)
    end
  end
end
