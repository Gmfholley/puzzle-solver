# frozen_string_literal: true

module Locations
  class ToString
    attr_reader :location

    def initialize(location)
      @location = location
    end

    def perform
      return occupant.to_s if occupied?

      [
        "     ",
        "  #{abbreviation}  "[0, 5],
        "     "
      ]
    end

    private

    def occupant
      location.occupant
    end

    def occupied?
      location.occupied?
    end

    def name
      location.name
    end

    def abbreviation
      name.to_s.split("_").map { |frag| frag[0] }.join.upcase
    end
  end
end
