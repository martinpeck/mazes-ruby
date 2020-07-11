require_relative "../models/polar_grid"
require_relative "../algorithms/recursive_backtracker"

grid = PolarGrid.new(25)
RecursiveBacktracker.on(grid)

start = grid[0, 0]
grid.distances = start.distances

filename = "output/polar_grid.png"
grid.to_png.save(filename)