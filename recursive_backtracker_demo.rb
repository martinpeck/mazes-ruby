require_relative 'colour_grid'
require_relative 'recursive_backtracker'

grid = ColourGrid.new(25,25)
RecursiveBacktracker.on(grid)

start = grid[grid.rows / 2, grid.columns / 2]

grid.distances = start.distances

filename = "output/recursive_backtracker_demo.png"
grid.to_png.save(filename)