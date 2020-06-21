class RecursiveBacktracker
  def self.on(grid, start_at: grid.random_cell)
    stack = []
    stack.push start_at

    while stack.any?
      current = stack.last
      neighbours = current.neighbours.select { |n| n.links.empty? }

      if neighbours.empty?
        stack.pop
      else
        neighbour = neighbours.sample
        current.link(neighbour)
        stack.push(neighbour)
      end
    end

    grid
  end
end
