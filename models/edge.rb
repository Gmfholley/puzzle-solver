# frozen_string_literal: true

class Edge
  attr_reader :image, :location

  def initialize(args = {})
    @image = args[:image] # HalfImage
    @location = args[:location] # ImageLocation
  end

  def matches?(edge)
    image.matches? edge.image
  end

  def relative_location(orientation)
    location.relative_location(orientation)
  end

  def ==(other_obj)
    image == other_obj.image
  end
end
