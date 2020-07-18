require_relative '../models/colour_grid'
require_relative '../algorithms/recursive_backtracker'

grid = ColourGrid.new(50,50)
RecursiveBacktracker.on(grid)
grid.braid(0.5)

start = grid[grid.rows / 2, grid.columns / 2]

grid.distances = start.distances

filename = "output/braided_recursive_backtracker.png"
grid.to_png.save(filename)
