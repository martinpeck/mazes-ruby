require_relative 'grid'

class BinaryTree
  def self.on(grid)
    grid.each_cell do |cell|
      neighbours = []
      neighbours << cell.north if cell.north
      neighbours << cell.east if cell.east

      index = rand(neighbours.length)
      neighbour = neighbours[index]

      cell.link(neighbour) if neighbour
    end

    grid
  end
end
