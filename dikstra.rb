require_relative 'distance_grid'
require_relative 'binary_tree'

grid = DistanceGrid.new(5,5)
BinaryTree.on(grid)

start_cell = grid[0, 0]
distances_from_start = start_cell.distances

grid.distances = distances_from_start
puts grid

puts "shortest path"
breadcrumbs = distances_from_start.path_to(grid[grid.rows - 1, 0])
grid.distances = breadcrumbs
puts grid