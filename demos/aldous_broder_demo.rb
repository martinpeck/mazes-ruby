require_relative '../models/colour_grid'
require_relative '../algorithms/aldous_broder'

grid = ColourGrid.new(25,25)
AldousBroder.on(grid)

start = grid[grid.rows / 2, grid.columns / 2]

grid.distances = start.distances

filename = "output/aldous_broder.png"
grid.to_png.save(filename)