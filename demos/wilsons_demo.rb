require_relative '../models/colour_grid'
require_relative '../algorithms/wilsons'

grid = ColourGrid.new(25,25)
Wilsons.on(grid)

start = grid[grid.rows / 2, grid.columns / 2]

grid.distances = start.distances

filename = "output/wilsons_demo.png"
grid.to_png.save(filename)