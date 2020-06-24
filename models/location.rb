# frozen_string)_literal: true

class Location
  attr_reader :name, :x_pos, :y_pos
  attr_accessor :occupant

  def initialize(args = {})
    @name = args[:name]
    @x_pos = args[:x]
    @y_pos = args[:y]
  end

  def occupied?
    !occupant.nil?
  end
end
