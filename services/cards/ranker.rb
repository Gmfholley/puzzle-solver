# frozen_string_literal: true

module Cards
  # Returns an array of cards, in order of easiest to hardest to place
  class Ranker
    attr_reader :cards

    def initialize(cards)
      @cards = cards
    end

    def perform
      ranked_cards.sort_by { |rc| rc.points }
        .map(&:card)
    end

    private

    def ranked_cards
      cards.map do |card|
        rc = Cards::Ranked.new(card)
        images = card.edges.map(&:image)
        rc.points = images.sum { |i| worst_to_best_image_names.index(i.name) }
        rc
      end
    end

    # More matched is better, unmatched is worse
    # Because we will point by index, and we want those with the most match to be first
    def worst_to_best_image_names
      @worst_to_best_images ||= unmatched_images_tally.sort_by { |_image_name, num_unmatched| num_unmatched }.reverse.to_h.keys
    end

    def unmatched_images_tally
      Cards::UnmatchedTally.new(cards).perform
    end
  end
end
