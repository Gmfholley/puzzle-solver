# frozen_string_literal: true

require_relative "../../test"

module Cards
  class RankedTest < Test::Unit::TestCase
    def subject
      Cards::Ranked.new(@card)
    end

    def setup
      @card = Factories::Cards.perform(CARDS).sample
    end

    def test_returns_this_type
      assert_kind_of Cards::Ranked, subject
    end

    def test_shoud_respond_to_points
      assert_respond_to subject, :points
    end

    def test_shoud_respond_to_points=
      assert_respond_to subject, :points=
    end

    def test_should_change_points
      num = 5
      s = subject.dup
      s.points = num
      assert_equal num, s.points
    end
  end
end
