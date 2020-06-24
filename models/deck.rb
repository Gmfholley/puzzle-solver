# frozen_string_literal: true

class Deck

  attr_reader :cards

  def initialize(args = {})
    @cards = args[:cards] || []
    @map = args[:map]
  end

  def length?
    cards.length
  end
end
