require_relative 'cell'
require_relative 'distances'

class WeightedCell < Cell
  attr_accessor :weight

  def initialize(row, column)
    super(row, column)
    @weight = 1
  end

  def distances
    weights = Distances.new(self)
    pending = [ self ]

    while pending.any?
      cell = pending.sort_by { |c| weights[c] }.first
      pending.delete(cell)

      cell.links.each do | neighbour|
        total_weight = weights[cell] + neighbour.weight

        if !weights[neighbour] || total_weight < weights[neighbour]
          pending << neighbour
          weights[neighbour] = total_weight
        end
      end
    end

    weights
  end

end