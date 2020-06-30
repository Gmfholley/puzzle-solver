# frozen_string_literal: true

require_relative "../../test"

module Cards
  class OptionTest < Test::Unit::TestCase
    def subject
      Cards::Option.new(@card)
    end

    def setup
      @card = Factories::Cards.perform(CARDS).sample
      @location = LOCATIONS.map { |i| Location.new(i) }.sample
      @map = Map.new([@location], Direction.all)
    end

    def test_returns_this_type
      assert_kind_of Cards::Option, subject
    end

    def test_shoud_respond_to_mark
      assert_respond_to subject, :mark
    end

    def test_shoud_change_tried_when_marked
      s = subject
      refute s.tried?
      s.mark
      assert s.tried?
    end

    def test_should_set_card_to_location_in_orientation
      s = subject

      refute @location.occupied?
      s.to(@location)
      assert @location.occupied?
      assert_equal @location.occupant, s.card
      assert s.tried?
    end

    def test_should_set_clear_location
      s = subject

      s.to(@location)
      s.clear

      refute @location.occupied?
      assert s.tried?
    end

    def test_equality_checks_if_card_and_orientation_match
      first = subject
      second = subject

      assert_equal first, second
      second.orientation = Direction.find(:south)
      refute_equal first, second
    end
  end
end
