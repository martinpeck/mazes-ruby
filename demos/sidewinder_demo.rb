require_relative '../models/grid'
require_relative '../algorithms/sidewinder'

my_grid = Grid.new(15, 15)
Sidewinder.on(my_grid)

img = my_grid.to_png cell_size:20, wall_size:2
img.save "output/sidewinder.png"

File.write("output/sidewinder.txt", my_grid)