require_relative "../models/hex_grid"
require_relative "../algorithms/recursive_backtracker"

grid = HexGrid.new(25, 30)
RecursiveBacktracker.on(grid)

filename = "output/hex.png"
grid.to_png.save(filename)