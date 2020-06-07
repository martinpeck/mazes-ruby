require_relative 'distance_grid'
require_relative 'binary_tree'

grid = DistanceGrid.new(5,5)
BinaryTree.on(grid)
start_cell = grid[0, 0]

# calculate max distance from root
distances = start_cell.distances
new_start_cell, distance = distances.max

puts "This is the path from the root to the furthest cell"
grid.distances = distances.path_to(new_start_cell)
puts grid

# take the furthest cell and calculate the max distance from THIS cell
new_distances = new_start_cell.distances
goal, distance = new_distances.max

puts "This is the path from that furthest cell to the cell furthest away from it."
grid.distances = new_distances.path_to(goal)
puts grid

