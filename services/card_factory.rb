# frozen_string_literal: true

class CardFactory

  def self.perform(args)
    collection_args = args.is_a?(Hash) ? [args] : args

    collection_args.map do |edge_args|
      edges = EdgeFactory.perform(edge_args)
      Card.new(edges: edges)
    end
  end
end
