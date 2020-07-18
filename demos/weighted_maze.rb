require_relative '../models/weighted_grid'
require_relative '../algorithms/recursive_backtracker'

rows ,cols = 20, 20

grid = WeightedGrid.new(rows, cols)
RecursiveBacktracker.on(grid)

grid.braid 0.5
start, finish = grid[0,0], grid[rows - 1, cols - 1]

grid.distances = start.distances.path_to(finish)
filename = 'output/weighted_original.png'
grid.to_png.save(filename)


lava = grid.distances.cells.sample
lava.weight = 50

grid.distances = start.distances.path_to(finish)
filename = 'output/weighted_with_lava.png'
grid.to_png.save(filename)
