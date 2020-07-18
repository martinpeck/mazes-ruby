# frozen_string_literal: true

class Kruskals
  class State
    attr_reader :neighbours

    def initialize(grid)
      @grid = grid
      @neighbours = []
      @set_for_cell = {}
      @cells_in_set = {}

      @grid.each_cell do |cell|
        set = @set_for_cell.length

        @set_for_cell[cell] = set
        @cells_in_set[set] = [cell]

        @neighbours << [cell, cell.south] if cell.south
        @neighbours << [cell, cell.east] if cell.east
      end
    end

    def can_merge?(left, right)
      @set_for_cell[left] != @set_for_cell[right]
    end

    def merge(left, right)
      left.link(right)

      winner = @set_for_cell[left]
      loser  = @set_for_cell[right]
      losers = @cells_in_set[loser] || [right]

      losers.each do |cell|
        @cells_in_set[winner] << cell
        @set_for_cell[cell] = winner
      end

      @cells_in_set.delete(loser)
    end
  end

  def self.on(grid, state = State.new(grid))
    neighbours = state.neighbours.shuffle

    while neighbours.any?
      left, right = neighbours.pop
      state.merge(left, right) if state.can_merge?(left, right)
    end
  end
end
