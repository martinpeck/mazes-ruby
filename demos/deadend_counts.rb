require_relative '../models/grid'
require_relative '../algorithms/binary_tree'
require_relative '../algorithms/sidewinder'
require_relative '../algorithms/aldous_broder'
require_relative '../algorithms/wilsons'
require_relative '../algorithms/hunt_and_kill'
require_relative '../algorithms/recursive_backtracker'

algorithms = [BinaryTree, Sidewinder, AldousBroder, Wilsons, HuntAndKill, RecursiveBacktracker]

tries = 100
size = 20

averages = {}
algorithms.each do |algorithm|
    puts "running #{algorithm}"
    
    deadends_counts = []
    tries.times do
        grid = Grid.new(size, size)
        algorithm.on(grid)
        deadends_counts << grid.deadends.count
    end
    
    total_deadends = deadends_counts.inject(0) { |s, a| s + a }
    averages[algorithm] = total_deadends / deadends_counts.length
end

total_cells = size * size
puts
puts "Average dead-ends per #{size}x#{size} maze (#{total_cells} cells):"
puts

sorted_algorithms = algorithms.sort_by { |algorithm| -averages[algorithm] }

sorted_algorithms.each do |algorithm|
    percentage = averages[algorithm] * 100.0 / (size * size)
    puts "%20s : %3d/%d (%d%%)" % [algorithm, averages[algorithm], total_cells, percentage]
end
