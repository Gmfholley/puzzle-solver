

Map has many locations
Location belongs to a Map
Location has x, y, occupant




Card has many edges
  and can be assigned to (belongs to) a Location
Card Location belongs to a location and a map
Card has an orientation


Edge belongs to an image and an image location

1. Find center location
1. Place a card there (starting in order of ranking)
1. Get compatible cards in all directions
1. Pick direction with least number of compatible options
1. Pick adjacent one with least number of compatible options
1. Alternate in each direction in an arc

   Arc
   X  X  X
   X     X
X  X  X  X
   X