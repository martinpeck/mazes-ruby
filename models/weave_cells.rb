# frozen_string_literal: true

require_relative 'cell'

class OverCell < Cell
  def initialize(row, column, grid)
    super(row, column)
    @grid = grid
  end

  def neighbours
    list = super
    list << north.north if can_tunnel_north?
    list << south.south if can_tunnel_south?
    list << east.east if can_tunnel_east?
    list << west.west if can_tunnel_west?
    list
  end

  def can_tunnel_north?
    north&.north && north&.horizontal_passage?
  end

  def can_tunnel_south?
    south&.south && south&.horizontal_passage?
  end

  def can_tunnel_east?
    east&.east && east&.vertical_passage?
  end

  def can_tunnel_west?
    west&.west && west&.vertical_passage?
  end

  def horizontal_passage?
    linked?(east) && linked?(west) && !linked?(north) && !linked?(south)
  end

  def vertical_passage?
    linked?(north) && linked?(south) && !linked?(east) && !linked?(west)
  end
  
  def link(cell, bidi=true)
    if north && north == cell.south
      neighbour = north
    elsif south && south == cell.north
      neighbour = south
    elsif east && east == cell.west
      neighbour == east
    elsif west && west == cell.east
      neighbour = west
    end

    if neighbour
      @grid.tunnel_under(neighbour)
    else
      super
    end
  end
end

class UnderCell < Cell
  
  def initialize(over_cell)
    super(over_cell.row, over_cell.column)
    
    if over_cell.horizontal_passage?
      self.north = over_cell.north
      over_cell.north.south = self
      self.south = over_cell.south
      over_cell.south.north = self
      link(north)
      link(south)
    else
      self.east = over_cell.east
      over_cell.east.west = self
      self.west = over_cell.west
      over_cell.west.east = self
      link(east)
      link(west)
    end
  end
  
  def horizontal_passage?
    east || west
  end
  
  def vertical_passage?
    north || south
  end

end
