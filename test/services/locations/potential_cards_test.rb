# frozen_string_literal: true

require_relative "../../test"

module Locations
  class PotentialCardsTest < Test::Unit::TestCase
    def subject
      Locations::PotentialCards.new(@location, @cards).perform
    end

    def setup
      @locations = LOCATIONS.map { |i| Location.new(i) }
      @map = Map.new(@locations, Direction.all)
      @cards = Factories::Cards.perform(CARDS)
      @num_directions = Direction.all.length
    end

    def test_returns_array
      @location = @locations.find { |loc| loc.name == :north }

      assert_kind_of Array, subject
    end

    def test_should_include_all_cards_when_map_unoccupied
      @location = @locations.sample

      assert_equal @cards, subject.map(&:card).uniq
      assert_equal @cards.length * @num_directions, subject.length
    end

    def test_should_be_empty_array_when_location_is_occupied
      @location = @locations.sample
      @map.place(@location, @cards.first, Direction.north)

      assert_equal 0, subject.length
    end

    def test_should_not_include_placed_card
      @north = @locations.find { |loc| loc.name == :north }
      @location = @locations.find { |loc| loc.name == :south }
      @card = @cards.sample
      @map.place(@north, @card, Direction.north)

      assert_nil subject.find { |option| option.card == @card }
      assert_equal (@cards.length - 1) * @num_directions, subject.length
    end

    def test_should_test_for_cards_that_match_position
      locations = [
        @locations.find { |loc| loc.name == :north },
        @locations.find { |loc| loc.name == :east },
        @locations.find { |loc| loc.name == :south },
        @locations.find { |loc| loc.name == :west }
      ]
      @location = @locations.find { |loc| loc.name == :center }
      @cards = Factories::Cards.perform(CARDS_TEST)
      (0..3).to_a.map { |i| @map.place(locations[i], @cards[i], Direction.north) }

      puts "show map"
      puts @map.to_s
      subject.each do |s|
        s.card.orientation = s.orientation
        puts s.card.to_s
      end

      assert_equal 2, subject.length
    end

    def test_requires_params
      @location = nil
      @cards = nil
      assert_raise { subject }
    end
  end
end
