# frozen_string_literal: true

module Factories
  # Makes a collection of Edges, with a direction key and a set of image params
  class Edges
    def self.perform(args = {})
      args.map do |direction, image_params|
        image_location = ImageLocation.new(direction)
        image = HalfImage.new(image_params)
        Edge.new(image: image, location: image_location)
      end
    end
  end
end
