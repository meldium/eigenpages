#!/usr/bin/env ruby

require 'chunky_png'
require 'parallel'

# These produce nice even tile sizes, but they are oddly shaped
TILE_SIZE_X = 5 #* 5
TILE_SIZE_Y = 6 #* 2

COMPONENTS = %i(r g b)

files = Dir['data/*.png']

Parallel.each(files) do |file|
  png = ChunkyPNG::Image.from_file(file)
  width = png.width
  height = png.height

  tiles = (0...(width / TILE_SIZE_X)).map { |x| (0...(height / TILE_SIZE_Y)).map { |y| Hash[[[:count, 0]] + (COMPONENTS.map { |c| [c, 0] })] } }

  png.pixels.each_with_index do |pixel, index|
    x = index % width
    y = index / width
    x_tile = x / TILE_SIZE_X
    y_tile = y / TILE_SIZE_Y

    tile = tiles[x_tile][y_tile]
    COMPONENTS.each { |c| tile[c] += ChunkyPNG::Color.send(c, pixel) }
    tile[:count] += 1
  end

  out_png = ChunkyPNG::Image.new(tiles.length, tiles.first.length)
  out_row = []
  tiles.each_with_index do |rows, x|
    rows.each_with_index do |tile, y|
      colors = COMPONENTS.map { |c| tile[c] / tile[:count] }
      out_png[x, y] = ChunkyPNG::Color.rgb(*colors)
      out_row += colors
    end
  end

  File.open(file.gsub(/data/, 'vectors').gsub(/png/, 'txt'), 'w') { |f| f.puts out_row.join(',') }
  out_png.save(file.gsub(/data/, 'thumb.color'))
end
