# frozen_string_literal: true

require_relative 'colour_grid'

# MaskedGrid allows a maze to be generated with a mask applied
class MaskedGrid < ColourGrid
  attr_reader :mask

  def initialize(mask)
    @mask = mask
    super(@mask.rows, @mask.columns)
  end

  def prepare_grid
    Array.new(rows) do |row|
      Array.new(columns) do |col|
        Cell.new(row, col) if @mask[row, col]
      end
    end
  end

  def random_cell
    row, col = @mask.random_location
    self[row, col]
  end

  def size
    @mask.count
  end
end
