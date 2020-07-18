require_relative '../models/weave_grid'
require_relative '../algorithms/recursive_backtracker'

grid = WeaveGrid.new(50,50)
RecursiveBacktracker.on(grid)

filename = "output/weave_maze.png"
grid.to_png.save(filename)
