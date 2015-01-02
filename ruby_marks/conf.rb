$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'ruby_marks'

class Conf

  attr_reader :recognizer

  def initialize(recognizer)
    @recognizer = recognizer
  end

  def OMRsettings(tolerance, size, startx, endx, starty, betweeny)
    # Configuring the document aspects
    @recognizer.configure do |config|
      config.threshold_level = 50
      config.edge_level = 3
      config.default_expected_lines = 1
      config.default_block_width_tolerance = tolerance
      config.default_block_height_tolerance = tolerance
      config.default_mark_height = size
      config.default_mark_width = size
      config.default_distance_between_marks = size
      config.default_marks_options = %w{0 1 2 3 4 5 6 7 8 9}

      config.define_group :first  do |group|
          group.expected_coordinates = {x1: startx , y1: starty, x2: endx, y2: starty + betweeny * 1}
      end

      config.define_group :second  do |group|
          group.expected_coordinates = {x1: startx , y1: starty + betweeny * 1, x2: endx, y2: starty + betweeny * 2}
      end

      config.define_group :third  do |group|
          group.expected_coordinates = {x1: startx , y1: starty + betweeny * 2, x2: endx, y2: starty + betweeny * 3}
      end

      config.define_group :forth  do |group|
          group.expected_coordinates = {x1: startx , y1: starty + betweeny * 3, x2: endx, y2: starty + betweeny * 4}
      end

      config.define_group :fifth  do |group|
          group.expected_coordinates = {x1: startx , y1: starty + betweeny * 4, x2: endx, y2: starty + betweeny * 5}
      end

      config.define_group :sixth  do |group|
          group.expected_coordinates = {x1: startx , y1: starty + betweeny * 5, x2: endx, y2: starty + betweeny * 6}
      end

      config.define_group :seventh  do |group|
          group.expected_coordinates = {x1: startx , y1: starty + betweeny * 6, x2: endx, y2: starty + betweeny * 7}
      end

      config.define_group :eighth  do |group|
          group.expected_coordinates = {x1: startx , y1: starty + betweeny * 7, x2: endx, y2: starty + betweeny * 8}
      end

      config.define_group :nineth  do |group|
          group.expected_coordinates = {x1: startx , y1: starty + betweeny * 8, x2: endx, y2: starty + betweeny * 9}
      end
    end
  end
end