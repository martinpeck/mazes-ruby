require_relative 'grid'
require_relative 'binary_tree'

my_grid = Grid.new(30, 30)
BinaryTree.on(my_grid)

img = my_grid.to_png cell_size:20, wall_size:2
img.save "output/binary_tree.png"

File.write("output/binary_tree.txt", my_grid)