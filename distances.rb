class Distances
  
  def initialize(root)
    @root = root
    @cells = {}
    @cells[@root] = 0
  end
  
  def [](cell)
    @cells[cell]
  end
  
  def []=(cell, distance)
    @cells[cell] = distance
  end
  
  def cells
    @cells.keys
  end
  
  def path_to(goal)
    current = goal
    
    breadcrumbs = Distances.new(@root)
    breadcrumbs[current] = @cells[current]
    
    until current == @root
      current.links.each do |neighbour|
        if @cells[neighbour] < @cells[current]
          breadcrumbs[neighbour] = @cells[neighbour]
          current = neighbour
          break
        end
      end
    end
  
    breadcrumbs
  end
  
end