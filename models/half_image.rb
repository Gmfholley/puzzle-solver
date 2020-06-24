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

  def valid?
    POSITIONS.include? position
  end
end
