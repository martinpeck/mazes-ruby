require_relative "../models/triangle_grid"
require_relative "../algorithms/recursive_backtracker"

grid = TriangleGrid.new(30, 50)
RecursiveBacktracker.on(grid)

start = grid[grid.rows / 2, grid.columns / 2]
grid.distances = start.distances

filename = "output/delta.png"
grid.to_png.save(filename)