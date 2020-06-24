# frozen_string_literal: true

module Cards
  Ranked = Struct.new(:card) {
    def points
      @points
    end

    def points=(points)
      @points = points
    end
  }
end
