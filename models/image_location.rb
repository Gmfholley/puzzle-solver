# frozen_string_literal: true

class ImageLocation
  attr_reader :name, :direction

  def initialize(name)
    @name = name
    @direction ||= Direction.find(name)
  end

  def opposite_location
    direction.opposite
  end

  def relative_location(orientation)
    direction.when_facing(orientation)
  end
end
