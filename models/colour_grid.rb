require_relative 'grid'
require 'chunky_png'

class ColourGrid < Grid
    
    def distances=(distances)
        @distances = distances
        farthese, @maximum = distances.max
    end

    def background_colour_for(cell)
        return nil if not @distances
        distance =  @distances[cell] or return nil
        intensity = (@maximum - distance).to_f / @maximum
        dark = (255 * intensity).round
        bright = 128 + (127 * intensity).round
        ChunkyPNG::Color.rgb(dark,bright,dark)
    end
end