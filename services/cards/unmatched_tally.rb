# frozen_string_literal: true

module Cards
  # Returns a Hash tally of the number of unmatched top and bottom pairs for all images in the stack of cards
  UnmatchedTally = Struct.new(:cards) {
    def perform
      unmatched_sets_tally
    end

    private

    def unmatched_sets_tally
      image_tally.keys.map { |key| [key, (top_half_tally.fetch(key, 0) - bottom_half_tally.fetch(key, 0)).abs] }.to_h
    end

    # TODO: When ruby 2.7 is stable, use tally Enum feature
    def tally(array)
      array.group_by { |v| v }.map { |k, v| [k, v.size] }.to_h
    end

    def image_tally
      @image_tally ||= tally(images.map(&:name))
    end

    def top_half_tally
      @top_half_tally ||= tally(images.select { |img| img.top? }.map(&:name))
    end

    def bottom_half_tally
      @bottom_half_tally ||= tally(images.select { |img| img.bottom? }.map(&:name))
    end

    def images
      cards.flat_map(&:edges).map(&:image)
    end
  }
end
