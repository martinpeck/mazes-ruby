require_relative '../algorithms/kruskal.rb'
require_relative '../models/grid'

grid = Grid.new(20, 20)
Kruskals.on(grid)

filename = 'output/krushals.png'
grid.to_png(inset:0.1).save(filename)