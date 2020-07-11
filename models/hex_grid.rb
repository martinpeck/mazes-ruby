require_relative 'colour_grid'
require_relative 'hex_cell'

class HexGrid < ColourGrid
  def prepare_grid
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        HexCell.new(row, column)
      end
    end    
  end
  
  def configure_cells
    each_cell do |cell|
      row, col = cell.row, cell.column
      
      if col.even?
        north_diagonal = row - 1
        south_diagonal = row
      else
        north_diagonal = row
        south_diagonal = row + 1
      end
      
      cell.northwest  = self[north_diagonal, col - 1]
      cell.north      = self[row - 1, col]
      cell.northeast  = self[north_diagonal, col + 1]
      cell.southwest  = self[south_diagonal, col - 1]
      cell.south      = self[row + 1, col]
      cell.southeast  = self[south_diagonal, col + 1]
    end
  end
  
  def to_png(size: 10)
    a_size = size / 2.0
    b_size = size * Math.sqrt(3) / 2.0
    width  = size * 2
    height = b_size * 2
    
    img_width  = (3 * a_size * columns + a_size + 0.5).to_i
    img_height = (height * rows + b_size + 0.5).to_i
    
    background = ChunkyPNG::Color::WHITE
    wall       = ChunkyPNG::Color::BLACK
    
    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)
    
    [:backgrounds, :walls].each do |mode|
      each_cell do |cell|
        cx = size + 3 * cell.column * a_size
        cy = b_size + cell.row * height
        cy += b_size if cell.column.odd?
        
        # f = far
        # n = near
        # n/s/e/q = north/south/east/west
        x_fw = (cx - size).to_i
        x_nw = (cx - a_size).to_i
        x_ne = (cx + a_size).to_i
        x_fe = (cx + size).to_i
        
        # m = middle
        y_n = (cy - b_size).to_i
        y_m = cy.to_i
        y_s = (cy + b_size).to_i
        
        if mode == :backgrounds
          colour = background_colour_for(cell)
          if colour
            points = [
              [x_fw, y_m],
              [x-nw, y_n],
              [x_ne, y_n],
              [x_fe, y_m],
              [x_ne, y_s],
              [x_nw, y_s],
            ]
            img.polygon(points, colour, colour)
          end          
        else
          img.line(x_fw, y_m, x_nw, y_s, wall) unless cell.southwest
          img.line(x_fw, y_m, x_nw, y_n, wall) unless cell.northwest
          img.line(x_nw, y_n, x_ne, y_n, wall) unless cell.north
          img.line(x_ne, y_n, x_fe, y_m, wall) unless cell.linked?(cell.northeast)
          img.line(x_fe, y_m, x_ne, y_s, wall) unless cell.linked?(cell.southeast)
          img.line(x_ne, y_s, x_nw, y_s, wall) unless cell.linked?(cell.south)
        end
      end      
    end
    
    img
  end

end