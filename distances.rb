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
end