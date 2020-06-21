require_relative '../models/colour_grid'
require_relative '../algorithms/aldous_broder'

6.times do |n|
    
    grid = ColourGrid.new(20,20)
    AldousBroder.on(grid)

    middle = grid[grid.rows / 2, grid.columns / 2]
    grid.distances = middle.distances

    filename = "output/aldous_broder_%02d.png" % n
    grid.to_png.save(filename)
end

