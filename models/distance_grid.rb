# frozen_string_literal: true

require_relative 'grid'

# DistanceGrid allows distances from a reference cell to be displayed within each cell
class DistanceGrid < Grid
  attr_accessor :distances

  def contents_of(cell)
    if distances && distances[cell]
      distances[cell].to_s(36)
    else
      super
    end
  end
end
