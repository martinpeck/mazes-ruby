# frozen_string_literal: true

require 'chunky_png'

# Represents a mask that can be applied to a maze
class Mask
  attr_reader :rows, :columns

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @bits = Array.new(@rows) { Array.new(@columns, true) }
  end

  def [](row, column)
    if row.between?(0, @rows - 1) && column.between?(0, @columns - 1)
      @bits[row][column]
    else
      false
    end
  end

  def []=(row, column, is_on)
    @bits[row][column] = is_on
  end

  def count
    count = 0

    @rows.times do |row|
      @columns.times do |col|
        count += 1 if @bits[row][col]
      end
    end
  end

  def random_location
    loop do
      row = rand(@rows)
      col = rand(@cols)

      return [row, col] if @bits[row][col]
    end
  end

  def self.from_txt(file)
    lines = File.readlines(file).map(&:strip)
    lines.pop while lines.last.empty?

    rows = lines.length
    columns = lines.first.length
    mask = Mask.new(rows, columns)

    mask.rows.times do |row|
      mask.columns.times do |col|
        mask[row, col] = lines[row][col] != 'X'
      end
    end

    mask
  end

  def self.from_png(file)
    image = ChunkyPNG::Image.from_file(file)
    mask = Mask.new(image.height, image.width)

    mask.rows.times do |row|
      mask.columns.times do |col|
        mask[row, col] = image[row, col] != ChunkyPNG::Color::BLACK
      end
    end

    mask
  end
end
