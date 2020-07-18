# frozen_string_literal: false

require 'chunky_png'
require_relative 'cell'

# Base class for all maze grids
class Grid
  attr_reader :rows, :columns

  def initialize(rows, columns)
    @rows = rows
    @columns = columns

    @grid = prepare_grid
    configure_cells
  end

  def prepare_grid
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        Cell.new(row, column)
      end
    end
  end

  def configure_cells
    each_cell do |cell|
      row = cell.row
      col = cell.column

      cell.north = self[row - 1, col]
      cell.south = self[row + 1, col]
      cell.west  = self[row, col - 1]
      cell.east  = self[row, col + 1]
    end
  end

  def[](row, column)
    return nil unless row.between?(0, @rows - 1)
    return nil unless column.between?(0, @grid[row].count - 1)

    @grid[row][column]
  end

  def random_cell
    row = rand(@rows)
    col = rand(@grid[row].count)

    self[row, col]
  end

  def size
    @rows * @columns
  end

  def each_row
    @grid.each do |row|
      yield row
    end
  end

  def each_cell
    each_row do |row|
      row.each do |cell|
        yield cell if cell
      end
    end
  end

  def to_s
    output = '+' + '---+' * columns + "\n"

    each_row do |row|
      top = '|'
      bottom = '+'

      row.each do |cell|
        cell ||= Cell.new(-1, -1)

        body = " #{contents_of(cell)} "
        east_boundary = (cell.linked?(cell.east) ? ' ' : '|')
        top << body << east_boundary

        south_boundary = (cell.linked?(cell.south) ? '   ' : '---')
        corner = '+'
        bottom << south_boundary << corner
      end

      output << top << "\n"
      output << bottom << "\n"
    end

    output
  end

  def to_png(cell_size: 10, inset: 0)
    img_width  = cell_size * columns
    img_height = cell_size * rows
    inset = (cell_size * inset).to_i

    background_colour = ChunkyPNG::Color::WHITE
    wall_colour       = ChunkyPNG::Color :darkred

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background_colour)

    %i[backgrounds walls].each do |mode|
      each_cell do |cell|
        x = cell.column * cell_size
        y = cell.row * cell_size

        if inset > 0
          to_png_with_inset(img, cell, mode, cell_size, wall_colour, x, y, inset)
        else
          to_png_without_inset(img, cell, mode, cell_size, wall_colour, x, y)
        end
      end
    end

    img
  end

  def to_png_without_inset(img, cell, mode, cell_size, wall_colour, x, y)
    x1 = x
    y1 = y
    x2 = x1 + cell_size
    y2 = y1 + cell_size

    if mode == :backgrounds
      back_colour = background_colour_for(cell)
      img.rect(x, y, x2, y2, back_colour, back_colour) if back_colour
    else
      img.line(x1, y1, x2, y1, wall_colour) unless cell.north
      img.line(x1, y1, x1, y2, wall_colour) unless cell.west
      img.line(x1, y2, x2, y2, wall_colour) unless cell.linked?(cell.south)
      img.line(x2, y1, x2, y2, wall_colour) unless cell.linked?(cell.east)
    end
  end

  def to_png_with_inset(img, cell, mode, cell_size, wall_colour, x, y, inset)
    x1, x2, x3, x4, y1, y2, y3, y4 = cell_coordinates_with_inset(x, y, cell_size, inset)

    # TODO: add support for backgrounds
    if mode == :walls
      if cell.linked?(cell.north)
        img.line(x2, y1, x2, y2, wall_colour)
        img.line(x3, y1, x3, y2, wall_colour)
      else
        img.line(x2, y2, x3, y2, wall_colour)
      end

      if cell.linked?(cell.south)
        img.line(x2, y3, x2, y4, wall_colour)
        img.line(x3, y3, x3, y4, wall_colour)
      else
        img.line(x2, y3, x3, y3, wall_colour)
      end

      if cell.linked?(cell.west)
        img.line(x1, y2, x2, y2, wall_colour)
        img.line(x1, y3, x2, y3, wall_colour)
      else
        img.line(x2, y2, x2, y3, wall_colour)
      end

      if cell.linked?(cell.east)
        img.line(x3, y2, x4, y2, wall_colour)
        img.line(x3, y3, x4, y3, wall_colour)
      else
        img.line(x3, y2, x3, y3, wall_colour)
      end
    end
  end

  def cell_coordinates_with_inset(x, y, cell_size, inset)
    x1 = x
    x4 = x + cell_size
    x2 = x1 + inset
    x3 = x4 - inset

    y1 = y
    y4 = y + cell_size
    y2 = y1 + inset
    y3 = y4 - inset

    [x1, x2, x3, x4,
     y1, y2, y3, y4]
  end

  def contents_of(_cell)
    ' '
  end

  def background_colour_for(_cell)
    nil
  end

  def deadends
    list = []

    each_cell do |cell|
      list << cell if cell.links.count == 1
    end

    list
  end

  def braid(p = 1.0)
    deadends.shuffle.each do |cell|
      next if cell.links.count != 1 || rand > p

      neighbours = cell.neighbours.reject { |n| cell.linked?(n) }
      best = neighbours.select { |n| n.links.count == 1 }
      best = neighbours if best.empty?

      neighbour = best.sample
      cell.link(neighbour)
    end
  end
end
