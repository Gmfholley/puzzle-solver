# frozen_string_literal: true

require_relative "../../test"

module Cards
  class UnmatchedTallyTest < Test::Unit::TestCase
    def subject
      Cards::UnmatchedTally.new(@cards).perform
    end

    def setup
      @cards = Factories::Cards.perform(CARDS)
    end

    def test_returns_array
      assert_kind_of Hash, subject
    end

    def test_shoud_return_as_many_keys_as_there_are_image_names
      num_images = @cards.flat_map(&:edges).map { |edge| edge.image.name }.uniq

      assert_equal num_images.sort, subject.keys.sort
      assert_equal num_images.length, subject.keys.length
    end

    def test_values_should_be_integers
      assert subject.values.all? { |v| v.is_a? Numeric }
    end

    def test_should_subtract_top_from_bottom_tallies
      num = 4
      @cards = (1..num).to_a.map { |i|
        edges = (1..num).to_a.flat_map { Factories::Edges.perform({north: {name: i.to_s, position: :bottom}}) }
        Card.new(edges: edges)
      }

      assert_equal num, subject["1"]
      assert subject.values.all? { |v| v == num }
    end

    def test_should_subtract_show_tallies
      num = 4
      @cards = (1..num).to_a.map { |i|
        edges = (1..num).to_a.flat_map { |e|
          position = e.even? ? :top : :bottom
          Factories::Edges.perform({north: {name: i.to_s, position: position}})
        }
        Card.new(edges: edges)
      }

      assert_equal 0, subject["1"]
      assert_equal 0, subject["2"]
    end

    def test_requires_params
      @cards = nil
      assert_raise { subject }
    end
  end
end
