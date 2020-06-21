require_relative '../models/mask'
require_relative '../models/masked_grid'
require_relative '../algorithms/recursive_backtracker'

abort "Please specify a text file to use as a template" if ARGV.empty?
mask = Mask.from_txt(ARGV.first)
grid = MaskedGrid.new(mask)
RecursiveBacktracker.on(grid)

filename = "output/ascii_mask_demo.png"
grid.to_png.save(filename)