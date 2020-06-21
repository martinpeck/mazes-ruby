require_relative '../models/mask'
require_relative '../models/masked_grid'
require_relative '../algorithms/recursive_backtracker'

abort "Please specify a PNG file to use as a template" if ARGV.empty?
mask = Mask.from_png(ARGV.first)
grid = MaskedGrid.new(mask)
RecursiveBacktracker.on(grid)

start = grid[99, 0]
grid.distances = start.distances

filename = "output/image_mask.png"
grid.to_png(cell_size:5).save(filename)