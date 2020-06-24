# frozen_string_literal: true

module Factories
  class Edge
    def self.perform(args = {})
      args.map do |direction, image_params|
        image_location = ImageLocation.new(direction)
        image = HalfImage.new(image_params)
        ::Edge.new(image: image, location: image_location)
      end
    end
  end
end
