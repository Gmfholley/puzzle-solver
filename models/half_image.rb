# frozen_string_literal: true

class HalfImage
  POSITIONS = [:top, :bottom]

  attr_reader :name, :position

  def initialize(args = {})
    @name = args[:name]
    @position = args[:position]
  end

  def matches?(image)
    image.position != position && image.name == name
  end

  def top?
    !bottom?
  end

  def bottom?
    position == :bottom
  end

  def valid?
    POSITIONS.include? position
  end

  def ==(other_obj)
    name == other_obj.name && position == other_obj.position
  end
end
