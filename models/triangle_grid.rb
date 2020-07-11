require_relative 'colour_grid'
require_relative 'triangle_cell'

class TriangleGrid < ColourGrid

  def prepare_grid
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        TriangleCell.new(row, column)
      end
    end
  end

  def configure_cells
    each_cell do |cell|
      row, col = cell.row, cell.column

      cell.west  = self[row, col - 1]
      cell.east  = self[row, col + 1]
      cell.north = self[row - 1, col] unless cell.upright?
      cell.south = self[row + 1, col] if     cell.upright?
    end
  end

  def to_png(size: 16)

    half_width  = size / 2.0
    height      = size * Math.sqrt(3) / 2.0
    half_height = height / 2.0

    img_width  = (size * (columns + 1) / 2.0).to_i
    img_height = (height * rows).to_i
    background = ChunkyPNG::Color::WHITE
    wall       = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)
    
    [:backgrounds, :walls].each do |mode|
      each_cell do |cell|
        cx = half_width + cell.column * half_width
        cy = half_height + cell.row * height
        
        west_x = (cx - half_width).to_i
        mid_x  = cx.to_i
        east_x = (cx + half_width).to_i
        
        if cell.upright?
          apex_y = (cy - half_height).to_i
          base_y = (cy + half_height).to_i
        else
          apex_y = (cy + half_height).to_i
          base_y = (cy - half_height).to_i
        end
        
        if mode == :backgrounds
          colour = background_colour_for(cell)
          if colour
            points = [
              [west_x, base_y],
              [mid_x, apex_y],
              [east_x, base_y]                            
            ]
            img.polygon(points, colour, colour)
          end
        else
          unless cell.west
            img.line(west_x, base_y, mid_x, apex_y, wall)
          end
          unless cell.linked?(cell.east)
            img.line(east_x, base_y, mid_x, apex_y, wall)
          end
          
          no_south = cell.upright? && cell.south.nil?
          not_linked = !cell.upright? && !cell.linked?(cell.north)
          
          if no_south || not_linked
            img.line(east_x, base_y, west_x, base_y, wall)
          end
        end
      end
    end
    
    img

  end

end