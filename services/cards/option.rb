# frozen_string_literal: true

module Cards
  Option = Struct.new(:card, :orientation) {
    def unmarked?
      !tried?
    end

    def tried?
      @tried
    end

    def mark
      @tried = true
    end

    def to(location)
      mark
      location.place(card, orientation)
    end

    def clear
      card.location&.clear
    end

    def ==(other_obj)
      card == other_obj.card && orientation == other_obj.orientation
    end
  }
end
