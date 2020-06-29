# frozen_string_literal: true

require_relative "../../test"

class Locations::SolveTest < Test::Unit::TestCase
  def subject
    Locations::Solve.new(@center, @cards).perform
  end

  def setup
    @locations = LOCATIONS.map { |i| Location.new(i) }
    @map = Map.new(@locations, Direction.all)
    @center = @locations.find { |loc| loc.name == :center }
    @cards = Factories::Cards.perform(CARDS)
    @center.place(@cards.first, Direction.north)
  end

  def test_returns_boolean
    refute subject
  end

  def test_requires_params
    @center = nil
    @cards = nil
    assert_raise { subject }
  end
end
