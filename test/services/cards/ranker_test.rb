# frozen_string_literal: true

require_relative "../../test"

module Cards
  class RankerTest < Test::Unit::TestCase
    def subject
      Cards::Ranker.new(@cards).perform
    end

    def setup
      @cards = Factories::Cards.perform(CARDS)
    end

    def test_returns_array
      assert_kind_of Array, subject
    end

    def test_shoud_return_as_many_as_there_are_cards
      assert_equal @cards.length, subject.length
      assert_kind_of Card, subject.first
    end

    def test_values_should_include_all_cards
      assert subject.all? { |v| @cards.find { |c| c == v } }
    end

    def test_should_show_unmatched_first
      num = 4
      @cards = (1..num).to_a.map { |i|
        edges = (1..num).to_a.flat_map { |e|
          position = i.even? && e.even? ? :top : :bottom
          Factories::Edges.perform({north: {name: i.to_s, position: position}})
        }
        Card.new(edges: edges)
      }

      first_ranked_card = subject.first
      last_ranked_card = subject.last

      assert_equal [:bottom], first_ranked_card.edges.map { |edge| edge.image.position }.uniq.sort
      assert_equal [:bottom, :top], last_ranked_card.edges.map { |edge| edge.image.position }.uniq.sort
    end

    def test_requires_params
      @cards = nil
      assert_raise { subject }
    end
  end
end
