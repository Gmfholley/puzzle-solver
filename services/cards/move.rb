# frozen_string_literal: true

module Cards
  Move = Struct.new(:card, :direction, :options) {
    def tried?
      @tried
    end

    def mark
      @tried = true
    end

    def untried_neighbors
      options.reject(&:tried?)
    end

    def direction_value
      direction.value
    end

    def distance_from(move)
      direction_value - move.direction_value
    end

    def in_direction
      card.location.neighbor(direction)
    end
  }
end
