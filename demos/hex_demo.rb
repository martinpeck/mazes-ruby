require_relative "../models/hex_grid"
require_relative "../algorithms/recursive_backtracker"

grid = HexGrid.new(25, 30)
RecursiveBacktracker.on(grid)

start = grid[0, 0]
grid.distances = start.distances

filename = "output/hex.png"
grid.to_png.save(filename)