require_relative '../models/distance_grid'
require_relative '../algorithms/binary_tree'

grid = DistanceGrid.new(5,5)
BinaryTree.on(grid)

start_cell = grid[0, 0]
distances_from_start = start_cell.distances

grid.distances = distances_from_start

File.write("output/binary_tree_with_dikstra.txt", grid)

breadcrumbs = distances_from_start.path_to(grid[grid.rows - 1, 0])
grid.distances = breadcrumbs

File.write("output/binary_tree_with_dikstra_shortest_path.txt", grid)
