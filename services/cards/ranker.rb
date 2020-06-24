# frozen_string_literal: true

module Cards
  class Ranker

    attr_reader :cards

    def initialize(cards)
      @cards = cards
    end

    def perform
      ranked_cards.sort_by { |rc| rc.points }.map(&:card)
    end

    private

    def ranked_cards
      cards.map do |card|
        rc = Cards::Ranked.new(card)
        images = card.edges.map(&:image)
        rc.points = images.sum{|i| worst_to_best_image_names.index(i.name) }
        rc
      end
    end

    # More matched is better, unmatched is worse
    # Because we will award points by index, and we want those with the most match to be first
    def worst_to_best_image_names
      @worst_to_best_images ||= unmatched_sets_tally.sort_by { |_, v| v }.reverse.to_h.keys
    end

    def unmatched_sets_tally
      image_tally.keys.map {|key| [key, (top_half_tally.fetch(key, 0) - bottom_half_tally.fetch(key, 0)).abs] }.to_h
    end

    def image_tally
      @image_tally ||= tally(total_images.map(&:name))
    end

    # TODO: When ruby 2.7 is stable, use tally Enum feature
    def tally(array)
      array.group_by { |v| v }.map { |k, v| [k, v.size] }.to_h
    end

    def top_half_tally
      @top_half_tally ||= tally(total_images.select{ |img| img.top? }.map(&:name))
    end

    def bottom_half_tally
      @bottom_half_tally ||= tally(total_images.select{ |img| img.bottom? }.map(&:name))
    end

    def total_images
      cards.flat_map(&:edges).map(&:image)
    end
  end
end
