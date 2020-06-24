# frozen_string_literal: true

module Cards
  # Returns cards compatible with the card in the direction
  Compatible = Struct.new(:card, :cards, :direction) do
    def perform
      return [] if !card.placed?

      ranked_cards.sort_by { |rc| rc.points }.map(&:card)
    end

    private

    def compatible_cards

    end


    def available_cards
      cards.reject { |card| card.placed? }
    end
  end
end
