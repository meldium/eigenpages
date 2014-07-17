#!/usr/bin/env ruby

require 'chunky_png'

# These produce nice even tile sizes, but they are oddly shaped
TILE_SIZE_X = 25
TILE_SIZE_Y = 12

png = ChunkyPNG::Image.from_blob(ARGF.read)


width = png.width
height = png.height

puts
tile_start_x = 0
while tile_start_x < width

  tile_start_y = 0
  while tile_start_y < height
    tile_end_x = [tile_start_x + TILE_SIZE_X, width].min
    tile_end_y = [tile_start_y + TILE_SIZE_Y, height].min

    # Process this tile
    print "[#{tile_start_x}, #{tile_start_y}]<->[#{tile_end_x}, #{tile_end_y}], "

    tile_start_y += TILE_SIZE_Y
  end

  tile_start_x += TILE_SIZE_X
end
puts
