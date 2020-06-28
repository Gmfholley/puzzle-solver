# frozen_string_literal: true

module Locations
  # Recursively places next location given cards
  class Next
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
      cards.find { |c| location&.occupant && location&.occupant == c }&.clear
      location.clear
    end

    def all_placed?
      locations.all?(&:occupied?)
    end

    def make_moves
      return next_location if location.occupied?

      puts "Unmarked for #{location.name}: #{next_moves.select(&:unmarked?).length}"
      puts "location_index: #{location_index}"
      puts "num_locations: #{locations.length}"
      while next_moves.any?(&:unmarked?) && locations.any?(&:unoccupied?)
        move(next_moves.shift)
        puts location.map.to_s
        next_location
      end
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
      move.mark
      location.place(move.card, move.orientation)
    end
  end
end
