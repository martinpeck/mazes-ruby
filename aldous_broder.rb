class AldousBroder
    
    def self.on(grid)
        cell = grid.random_cell
        unvisited = grid.size - 1
        
        while unvisited > 0
            neighbour = cell.neighbours.sample
            
            if neighbour.links.empty?
                cell.link(neighbour)
                unvisited -= 1
            end
            
            cell = neighbour
        end
        
        grid
    end
end