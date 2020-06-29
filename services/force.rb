# frozen_string_literal: true

class Force
  include Logging
  attr_accessor :card_index
  attr_reader :cards, :map, :locations

  def initialize(map, cards)
    @map = map
    @locations = map.locations
    @cards = cards
  end

  def perform
    options = cards.flat_map { |card| Direction.all.map { |dir| Cards::Option.new(card, dir) } }
    sets = options.permutation(cards.length).select { |set| cards.all? { |c| set.map(&:card).include? c } }

    solved = false
    set_index = 0

    while (!solved && set_index < sets.length) do
      locations.each(&:clear)
      set = sets[set_index]

      set.each_with_index do |option, i|
        locations[i].place(option.card, option.orientation)
      end

      logger.info { "Map: \n#{@map.to_s.join("\n")}" }

      solved = locations.map(&:card).all? { |card| card.neighbors.compact.all? { |dir, loc| card.edges_match?(loc.card, dir) } }
      set_index += 1
    end
  end

  def unsolved?
    cards.any?(&:unplaced?)
  end

  def unfinished?
    @card_index < cards.length
  end
end
