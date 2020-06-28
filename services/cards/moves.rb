# frozen_string_literal: true

module Cards
  Moves = Struct.new(:card, :direction, :potential_neighbors) {
    def tried?
      @tried
    end

    def mark
      @tried = true
    end

    def untried_neighbors
      potential_neighbors.reject(&:tried?)
    end

    def direction_value
      direction.value
    end

    def in_direction
      card.location.neighbor(direction)
    end
  }
end