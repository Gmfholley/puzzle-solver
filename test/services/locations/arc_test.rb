# frozen_string_literal: true

require_relative "../../test"

module Locations
  class ArcTest < Test::Unit::TestCase
    def subject
      Locations::Arc.new(@location1, @location2).perform
    end

    def setup
      @locations = LOCATIONS.map { |i| Location.new(i) }
      @map = Map.new(@locations, Direction.all)
    end

    def test_returns_array
      @location1 = @locations.find { |loc| loc.name == :north }
      @location2 = @locations.find { |loc| loc.name == :east }

      assert_kind_of Array, subject
    end

    def test_should_include_right_top_corner
      @location1 = @locations.find { |loc| loc.name == :north }
      @location2 = @locations.find { |loc| loc.name == :east }
      @location3 = @locations.find { |loc| loc.name == :north_east }

      assert_equal [@location1, @location3, @location2].map(&:name), subject.map(&:name)
    end

    def test_should_include_right_top_corner_in_other_order
      @location1 = @locations.find { |loc| loc.name == :east }
      @location2 = @locations.find { |loc| loc.name == :north }
      @location3 = @locations.find { |loc| loc.name == :north_east }

      assert_equal [@location1, @location3, @location2].map(&:name), subject.map(&:name)
    end

    def test_should_include_left_top_corner
      @location1 = @locations.find { |loc| loc.name == :north }
      @location2 = @locations.find { |loc| loc.name == :west }
      @location3 = @locations.find { |loc| loc.name == :north_west }

      assert_equal [@location1, @location3, @location2].map(&:name), subject.map(&:name)
    end

    def test_should_include_left_bottom_corner
      @location1 = @locations.find { |loc| loc.name == :south }
      @location2 = @locations.find { |loc| loc.name == :west }
      @location3 = @locations.find { |loc| loc.name == :south_west }

      assert_equal [@location1, @location3, @location2].map(&:name), subject.map(&:name)
    end

    def test_should_include_right_bottom_corner
      @location1 = @locations.find { |loc| loc.name == :south }
      @location2 = @locations.find { |loc| loc.name == :east }
      @location3 = @locations.find { |loc| loc.name == :south_east }

      assert_equal [@location1, @location3, @location2].map(&:name), subject.map(&:name)
    end

    def test_for_four_by_four
      @locations = LOCATIONS_FOUR.map { |i| Location.new(i) }
      @map = Map.new(@locations, Direction.all)

      @location1 = @locations.find { |loc| loc.name == :west_north_west }
      @location2 = @locations.find { |loc| loc.name == :east_north }
      @location3 = @locations.find { |loc| loc.name == :west_north }

      assert_equal [@location1, @location3, @location2].map(&:name), subject.map(&:name)
    end

    def test_for_five_by_five
      @locations = LOCATIONS_FIVE.map { |i| Location.new(i) }
      @map = Map.new(@locations, Direction.all)

      @location1 = @locations.find { |loc| loc.name == :north_north }
      @location2 = @locations.find { |loc| loc.name == :east_east }

      path = [:north_north, :north_east, :north_east_north, :east_north_east, :east_east]
      assert_equal path, subject.map(&:name)
    end

    def test_requires_params
      @location1 = nil
      @location2 = nil
      assert_raise { subject }
    end
  end
end
