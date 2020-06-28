require_relative "../models/polar_grid"
require_relative "../algorithms/recursive_backtracker"

grid = PolarGrid.new(8,8)
RecursiveBacktracker.on(grid)

filename = "output/polar_grid_test.png"
grid.to_png.save(filename)

