require "test/unit"
require_relative "../app"

LOCATIONS_FOUR = [
  {
    name: :north_west_north,
    x: 2,
    y: -2
  },
  {
    name: :north_west,
    x: 2,
    y: -1
  },
  {
    name: :north_east,
    x: 2,
    y: 1
  },
  {
    name: :north_east_north,
    x: 2,
    y: 2
  },
  {
    name: :west_north_west,
    x: 1,
    y: -2
  },
  {
    name: :west_north,
    x: 1,
    y: -1
  },
  {
    name: :east_north,
    x: 1,
    y: 1
  },
  {
    name: :east_north_east,
    x: 1,
    y: 2
  },
  {
    name: :west_south_west,
    x: -1,
    y: -2
  },
  {
    name: :west_south,
    x: -1,
    y: -1
  },
  {
    name: :east_south,
    x: -1,
    y: 1
  },
  {
    name: :east_south_east,
    x: -1,
    y: 2
  },
  {
    name: :south_west_south,
    x: -2,
    y: -2
  },
  {
    name: :south_west,
    x: -2,
    y: -1
  },
  {
    name: :south_east,
    x: -2,
    y: 1
  },
  {
    name: :south_east_south,
    x: -2,
    y: 2
  }
]

LOCATIONS_FIVE = [
  {
    name: :north_west_north,
    x: 2,
    y: -2
  },
  {
    name: :north_west,
    x: 2,
    y: -1
  },
  {
    name: :north_north,
    x: 2,
    y: 0
  },
  {
    name: :north_east,
    x: 2,
    y: 1
  },
  {
    name: :north_east_north,
    x: 2,
    y: 2
  },
  {
    name: :west_north_west,
    x: 1,
    y: -2
  },
  {
    name: :west_north,
    x: 1,
    y: -1
  },
  {
    name: :north,
    x: 1,
    y: 0
  },
  {
    name: :east_north,
    x: 1,
    y: 1
  },
  {
    name: :east_north_east,
    x: 1,
    y: 2
  },
  {
    name: :west_west,
    x: 0,
    y: -2
  },
  {
    name: :west_west_north,
    x: 0,
    y: -1
  },
  {
    name: :center,
    x: 0,
    y: 0
  },
  {
    name: :east_east_north,
    x: 0,
    y: 1
  },
  {
    name: :east_east,
    x: 0,
    y: 2
  },
  {
    name: :west_south_west,
    x: -1,
    y: -2
  },
  {
    name: :west_south,
    x: -1,
    y: -1
  },
  {
    name: :south,
    x: -1,
    y: 0
  },
  {
    name: :east_south,
    x: -1,
    y: 1
  },
  {
    name: :east_south_east,
    x: -1,
    y: 2
  },

  {
    name: :south_west_south,
    x: -2,
    y: -2
  },
  {
    name: :south_west,
    x: -2,
    y: -1
  },
  {
    name: :south_south,
    x: -2,
    y: -0
  },
  {
    name: :south_east,
    x: -2,
    y: 1
  },
  {
    name: :south_east_south,
    x: -2,
    y: 2
  }
]

Direction.set_all(DIRECTIONS.map { |attrs| Direction.new(attrs) })
