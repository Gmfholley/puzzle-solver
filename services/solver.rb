# frozen_string_literal: true

class Solver
  include Logging
  attr_accessor :card_index
  attr_reader :cards, :map

  def initialize(map, cards)
    @map = map
    @cards = Cards::Ranker.new(cards).perform
    @card_index = 0
  end

  def perform
    @card_index = 0

    while (unsolved? && unfinished?) do
      logger.info "----------Card #{card_index + 1}------------"
      map.locations.each(&:clear)
      place_card_in_center

      success = solve_for_card

      @card_index += 1
    end

    if success
      logger.info "----------SOLVED------------"
      logger.info "----------Card #{card_index}------------"
      logger.info { "Map: \n#{map.to_s.join("\n")}" }
    end

    success
  end

  private

  def center
    @center ||= Locations::Center.new(map).perform
  end

  def unsolved?
    cards.any?(&:unplaced?)
  end

  def unfinished?
    @card_index < cards.length
  end

  def card
    cards[@card_index]
  end

  def place_card_in_center
    center.clear
    center.place(card, card.orientation)
  end

  def solve_for_card
    Locations::Solve.new(center, cards).perform
  end
end
