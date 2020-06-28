# frozen_string_literal: true

require_relative 'grid'
require 'chunky_png'

# Colour Grid
class ColourGrid < Grid
  def distances=(distances)
    @distances = distances
    _, @maximum = distances.max
  end

  def background_colour_for(cell)
    return nil unless @distances

    distance =  @distances[cell] or return nil
    intensity = (@maximum - distance).to_f / @maximum
    dark = (255 * intensity).round
    bright = 128 + (127 * intensity).round
    ChunkyPNG::Color.rgb(dark, bright, dark)
  end
end
