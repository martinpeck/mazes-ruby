require_relative '../models/colour_grid'
require_relative '../algorithms/binary_tree'

grid = ColourGrid.new(25,25)
BinaryTree.on(grid)

start = grid[grid.rows / 2, grid.columns / 2]

grid.distances = start.distances

filename = "output/colour_binary_tree_demo.png"
grid.to_png.save(filename)