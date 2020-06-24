# frozen_string_literal: true

module Factories
  # Makes a collection of cards (1 or many), returns an Array of Card objects
  class Cards
    def self.perform(args)
      collection_args = args.is_a?(Hash) ? [args] : args

      collection_args.map do |edge_args|
        edges = Factories::Edges.perform(edge_args)
        Card.new(edges: edges)
      end
    end
  end
end
