# frozen_string_literal: true

module Maps
  class Center
    attr_reader :map

    def initialize(map)
      @map = map
    end

    def perform
      map.locations.find{|loc| loc.x_pos == avg_x_pos && loc.y_pos == avg_y_pos }
    end

    private

    def avg_x_pos
      (x_positions.sum / x_positions.length).round
    end

    def avg_y_pos
      (y_positions.sum / y_positions.length).round
    end

    def x_positions
      map.locations.map(&:x_pos)
    end

    def y_positions
      map.locations.map(&:y_pos)
    end

  end
end
