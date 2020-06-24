# frozen_string_literal: true

module Factories
  class Card
    def self.perform(args)
      collection_args = args.is_a?(Hash) ? [args] : args

      collection_args.map do |edge_args|
        edges = Factories::Edge.perform(edge_args)
        ::Card.new(edges: edges)
      end
    end
  end
end
