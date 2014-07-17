#!/usr/bin/env ruby

require 'chunky_png'

png = ChunkyPNG::Image.from_blob(ARGF.read)
p [png.width, png.height]

#pixels = png.pixels.map { |p| %w(r g b).map { |channel| ChunkyPNG::Color.send(channel, p) } }
