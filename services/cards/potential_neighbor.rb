# frozen_string_literal: true

module Cards
  PotentialNeighbor = Struct.new(:card, :orientation) {
    def tried?
      @tried
    end

    def mark
      @tried = true
    end
  }
end
