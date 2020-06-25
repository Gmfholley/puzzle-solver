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

  def to_s
    first_char.send(position_case)
  end

  private

  def first_char
    name[0]
  end

  def position_case
    return :upcase if position == :top

    :downcase
  end
end
