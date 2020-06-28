# frozen_string_literal: true

module Cards
  # Returns cards compatible with the card in the direction
  Equal = Struct.new(:card, :other_card) {
    def perform
      return false unless same_edges?

      edges_in_same_order?
    end

    private

    def edges_in_same_order?
      location_diffs.uniq.length == 1
    end

    def location_diffs
      equivalent_edges.map do |edge, other_edge|
        location_diff(edge, other_edge)
      end
    end

    def location_diff(edge, other_edge)
      edge.location.value - other_edge.location.value
    end

    def same_edges?
      equivalent_edges.values.all?
    end

    def equivalent_edges
      @equivalent_edges ||= card.edges.map { |edge| [edge, other_card.edges.find { |e| edge == e }] }.to_h
    end
  }
end
