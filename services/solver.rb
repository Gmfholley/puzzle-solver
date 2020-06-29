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
    results = []

    while unfinished?
      start_card_log
      clear_map
      place_card_in_center
      # TODO: CREATE RESULT TO STORE THIS IN
      results.push([solve_for_card, map.to_s])

      @card_index += 1
    end
    success = results.any?

    end_log(results.map.with_index { |r, i| r.first ? [i, r.last] : r.first }.select{|r| r} ) if success

    success
  end

  private

  def start_card_log
    logger.info "----------Card #{card_index + 1}------------"
  end

  def end_log(successes)
    logger.info "----------SOLVED------------"
    logger.info "----#{successes.length} solutions------"

    successes.map do |succ|
      i = succ.first
      map = succ.last
      logger.info "----------SOLUTION------------"
      logger.info "----------Card #{i + 1}------------"
      logger.info { "Map: \n#{map.join("\n")}" }
    end
  end

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

  def clear_map
    map.ever_placed = 0
    map.locations.each(&:clear)
  end

  def place_card_in_center
    center.clear
    center.place(card, card.orientation)
  end

  def solve_for_card
    Locations::Solve.new(center, cards).perform
  end
end
