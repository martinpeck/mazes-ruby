require_relative 'colour_grid'
require_relative 'hunt_and_kill'

grid = ColourGrid.new(25,25)
HuntAndKill.on(grid)

start = grid[grid.rows / 2, grid.columns / 2]

grid.distances = start.distances

filename = "output/hunt_and_kill_demo.png"
grid.to_png.save(filename)