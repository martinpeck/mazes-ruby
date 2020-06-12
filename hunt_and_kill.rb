class HuntAndKill
    def self.on(grid)
        current = grid.random_cell
        
        while current
            unvisited_neighbours = current.neighbours.select { |n| n.links.empty? }
            
            if unvisited_neighbours.any?
                neighbour = unvisited_neighbours.sample
                current.link(neighbour)
                current = neighbour
            else
                current = nil
                
                grid.each_cell do |cell|
                    visited_neighbours = cell.neighbours.select { |n| n.links.any? }
                    if cell.links.empty? && visited_neighbours.any?
                        current = cell
                        neighbour = visited_neighbours.sample
                        current.link(neighbour)
                        break
                    end
                end
            end
        end
        
        grid
    end
end