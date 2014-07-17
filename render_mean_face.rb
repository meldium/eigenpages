#!/usr/bin/env ruby

require 'chunky_png'

vector = File.open('meanface.txt').readlines.first.chomp.split(' ').map(&:to_i)
out_png = ChunkyPNG::Image.new(57, 71)
pixels = vector.each_with_index.group_by { |_, i| i / 3 }.map { |k, v| v.map { |x| x[0] } }

pixels.each_with_index do |components, i|
  y = i % 71
  x = i / 71
  out_png[x, y] = ChunkyPNG::Color.rgb(*components)
end

out_png.save('meanface.png')
