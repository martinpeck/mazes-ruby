require_relative 'mask'
require_relative 'masked_grid'
require_relative 'recursive_backtracker'

abort "Please specify a PNG file to use as a template" if ARGV.empty?
mask = Mask.from_png(ARGV.first)
grid = MaskedGrid.new(mask)
RecursiveBacktracker.on(grid)

start = grid[99, 0]
grid.distances = start.distances

filename = "output/image_mask_demo.png"
grid.to_png(cell_size:5).save(filename)