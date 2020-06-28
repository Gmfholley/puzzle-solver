# frozen_string_literal: true

module Cards
  class ToString
    attr_reader :card

    def initialize(card)
      @card = card
    end

    # Returns an Array of Strings
    # Representing orientation (up == north) and position of edges
    #     N
    #  W    E
    #     S
    #
    def perform
      [
        "  #{sorted_edges[0]}  ",
        "#{sorted_edges[3]}   #{sorted_edges[1]}",
        "  #{sorted_edges[2]}  "
      ]
    end

    private

    def sorted_edges
      edges.sort_by { |e| e.relative_location(orientation).value }
    end

    def orientation
      card.orientation
    end

    def edges
      card.edges
    end
  end
end
