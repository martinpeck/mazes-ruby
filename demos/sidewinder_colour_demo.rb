require_relative '../models/colour_grid'
require_relative '../algorithms/sidewinder'

grid = ColourGrid.new(25,25)
Sidewinder.on(grid)

start = grid[grid.rows / 2, grid.columns / 2]

grid.distances = start.distances

filename = "output/sidewinder_colour.png"
grid.to_png.save(filename)