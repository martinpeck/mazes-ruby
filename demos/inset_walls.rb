require_relative '../models/colour_grid'
require_relative '../algorithms/recursive_backtracker'

grid = ColourGrid.new(25,25)
RecursiveBacktracker.on(grid)
grid.braid(0.5)

filename = "output/inset_walls.png"
grid.to_png(inset:0.1).save(filename)