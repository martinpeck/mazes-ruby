require_relative 'colour_grid'
require_relative 'sidewinder'

grid = ColourGrid.new(25,25)
Sidewinder.on(grid)

start = grid[grid.rows / 2, grid.columns / 2]

grid.distances = start.distances

filename = "output/colour_sidewinder_demo.png"
grid.to_png.save(filename)