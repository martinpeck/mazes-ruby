require 'chunky_png'
require_relative 'cell'

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
        cell = Cell.new(-1, -1) unless cell      

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
  
  def to_png(cell_size: 10, wall_size: 1)
    img_width  = cell_size * columns
    img_height = cell_size * rows
    
    background_colour = ChunkyPNG::Color::WHITE
    wall_colour       = ChunkyPNG::Color:darkred
    grid_lines        = ChunkyPNG::Color:lightgrey
    
    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background_colour)
    
    each_cell do |cell|
      x1 = cell.column * cell_size
      y1 = cell.row * cell_size
      x2 = (cell.column + 1) * cell_size
      y2 = (cell.row + 1) * cell_size
      
      img.rect(x1,y1,x2,y2, grid_lines)
    
      wall_adjustment = (wall_size > 1) ? wall_size - 1 : 1
      img.rect(x1, y1, x2, y1 + wall_adjustment , wall_colour, wall_colour) unless cell.north
      img.rect(x1, y1, x1 + wall_adjustment, y2, wall_colour, wall_colour) unless cell.west
      
      wall_adjustment = wall_size
      img.rect(x1, y2, x2, y2 - wall_adjustment, wall_colour, wall_colour) unless cell.linked?(cell.south)
      img.rect(x2, y1, x2 - wall_adjustment, y2, wall_colour, wall_colour) unless cell.linked?(cell.east)
    end
  
    img
  end
  
  def contents_of(cell)
    " "
  end
  
end
