# frozen_string)_literal: true

class Direction
  attr_reader :name, :value, :x_move, :y_move

  def self.set_all(all)
    @@directions = all
  end

  def self.all
    @@directions
  end

  def self.find(name)
    all.find{|dir| dir.name == name}
  end

  def self.find_by_value(value)
    all.find{|dir| dir.value == value}
  end

  def self.north
    find(:north)
  end


  def initialize(args = {})
    @name = args[:name]
    @value = args[:value]
    @x_move = args[:x_move]
    @y_move = args[:y_move]
  end

  def opposite
    count = Direction.all.length
    opposite_value = (value + (count / 2)).round % count

    Direction.find_by_value(opposite_value)
  end

  def when_facing(orientation)
    return self if orientation == Direction.north

    count = Direction.all.length
    new_value = (value - orientation.value) % count

    Direction.find_by_value(new_value)
  end

  def ==(other_obj)
    value == other_obj.value && name == other_obj.name
  end
end
