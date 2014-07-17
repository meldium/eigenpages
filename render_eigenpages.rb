#!/usr/bin/env ruby

require 'chunky_png'

X = 57 * 5
Y = 71 * 2

File.open('eigenpages.txt').readlines.first(20).each_with_index do |line, line_index|
  vector = line.chomp.split(' ').map(&:to_i)
  out_png = ChunkyPNG::Image.new(X, Y)
  pixels = vector.each_with_index.group_by { |_, i| i / 3 }.map { |k, v| v.map { |x| x[0] } }

  pixels.each_with_index do |components, i|
    y = i % Y
    x = i / Y
    out_png[x, y] = ChunkyPNG::Color.rgb(*components)
  end

  out_png.save("eigenpages/#{line_index}.png")
end
