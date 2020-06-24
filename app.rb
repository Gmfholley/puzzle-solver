require "pry"
Dir[File.join(__dir__, "models", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "services", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "services/cards", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "services/factories", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "services/locations", "*.rb")].each { |file| require file }

LOCATIONS = [
  {
    name: :north_west,
    x: 1,
    y: -1
  }, {
    name: :north,
    x: 1,
    y: 0
  },
  {
    name: :north_east,
    x: 1,
    y: 1
  },
  {
    name: :west,
    x: 0,
    y: -1
  },
  {
    name: :center,
    x: 0,
    y: 0
  },
  {
    name: :east,
    x: 0,
    y: 1
  },
  {
    name: :south_west,
    x: -1,
    y: -1
  },
  {
    name: :south,
    x: -1,
    y: 0
  },
  {
    name: :south_east,
    x: -1,
    y: 1
  }
]

CARDS = [
  {
    north: {name: :orange_tabby, position: :top},
    east: {name: :gray, position: :top},
    south: {name: :siamese, position: :bottom},
    west: {name: :calico, position: :top}
  },
  {
    north: {name: :gray, position: :top},
    east: {name: :siamese, position: :top},
    south: {name: :calico, position: :top},
    west: {name: :orange_tabby, position: :bottom}
  },
  {
    north: {name: :calico, position: :bottom},
    east: {name: :orange_tabby, position: :top},
    south: {name: :siamese, position: :top},
    west: {name: :calico, position: :top}
  },
  {
    north: {name: :siamese, position: :bottom},
    east: {name: :gray, position: :bottom},
    south: {name: :orange_tabby, position: :top},
    west: {name: :calico, position: :top}
  },
  {
    north: {name: :orange_tabby, position: :bottom},
    east: {name: :siamese, position: :bottom},
    south: {name: :gray, position: :top},
    west: {name: :siamese, position: :top}
  },
  {
    north: {name: :calico, position: :bottom},
    east: {name: :orange_tabby, position: :bottom},
    south: {name: :siamese, position: :bottom},
    west: {name: :gray, position: :bottom}
  },
  {
    north: {name: :gray, position: :bottom},
    east: {name: :orange_tabby, position: :bottom},
    south: {name: :calico, position: :top},
    west: {name: :gray, position: :top}
  },
  {
    north: {name: :orange_tabby, position: :bottom},
    east: {name: :calico, position: :bottom},
    south: {name: :siamese, position: :top},
    west: {name: :gray, position: :top}
  },
  {
    north: {name: :orange_tabby, position: :bottom},
    east: {name: :gray, position: :top},
    south: {name: :siamese, position: :top},
    west: {name: :calico, position: :bottom}
  }
]

DIRECTIONS = [
  {
    name: :north,
    value: 0,
    x_move: 1,
    y_move: 0
  },
  {
    name: :east,
    value: 1,
    x_move: 0,
    y_move: 1
  },
  {
    name: :south,
    value: 2,
    x_move: -1,
    y_move: 0
  },
  {
    name: :west,
    value: 3,
    x_move: 0,
    y_move: -1
  }
]

Direction.set_all(DIRECTIONS.map { |attrs| Direction.new(attrs) })

locations = LOCATIONS.map { |i| Location.new(i) }
map = Map.new(locations, Direction.all)

cards = Factories::Cards.perform(CARDS)
