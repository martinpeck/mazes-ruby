require_relative 'distance_grid'
require_relative 'binary_tree'

grid = DistanceGrid.new(5,5)
BinaryTree.on(grid)

start_cell = grid[0, 0]
distances_from_start = start_cell.distances

grid.distances = distances_from_start

puts grid
File.write("output/binary_tree_with_dikstra.txt", grid)

breadcrumbs = distances_from_start.path_to(grid[grid.rows - 1, 0])
grid.distances = breadcrumbs

puts "shortest path..."
File.write("output/binary_tree_with_dikstra_shortest_path.txt", grid)
puts grid