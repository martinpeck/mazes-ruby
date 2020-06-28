require_relative 'grid'
require 'chunky_png'

class PolarGrid < Grid
    def to_png(cell_size: 10)
        img_size = 2 * @rows * cell_size
        
        background = ChunkyPNG::Color::WHITE
        wall = ChunkyPNG::Color::BLACK
        
        img = ChunkyPNG::Image.new(img_size + 1, img_size + 1, background)
        centre = img_size / 2
        
        each_cell do |cell|
            theta           = 2 * Math::PI / @grid[cell.row].length
            inner_radius    = cell.row * cell_size
            outer_radius    = (cell.row + 1) * cell_size
            theta_ccw       = cell.column * theta
            theta_cw       = (cell.column + 1) * theta
            
            ax = centre + (inner_radius * Math.cos(theta_ccw)).to_i
            ay = centre + (inner_radius * Math.sin(theta_ccw)).to_i
            bx = centre + (outer_radius * Math.cos(theta_ccw)).to_i
            by = centre + (outer_radius * Math.sin(theta_ccw)).to_i
            cx = centre + (inner_radius * Math.cos(theta_cw)).to_i
            cy = centre + (inner_radius * Math.sin(theta_cw)).to_i
            dx = centre + (outer_radius * Math.cos(theta_cw)).to_i
            dy = centre + (outer_radius * Math.sin(theta_cw)).to_i
            
            img.line(ax, ay, cx, cy, wall) unless cell.linked?(cell.north)
            img.line(cx, cy, dx, dy, wall) unless cell.linked?(cell.east)
        end
        
        img.circle(centre, centre, @rows * cell_size, wall)
        img
    end 
end