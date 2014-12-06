require 'rubygems'
require 'bundler/setup'
require 'ruby_marks'

# Instantiate the Recognizer
@file = 'ss5.png'
@recognizer = RubyMarks::Recognizer.new

# Configuring the document aspects
@recognizer.configure do |config|
  config.threshold_level = 50
  config.edge_level = 3
  config.default_expected_lines = 1
  config.default_block_width_tolerance = 50
  config.default_block_height_tolerance = 50
  config.default_mark_height = 50
  config.default_mark_width = 50
  config.default_distance_between_marks = 50
  config.default_marks_options = %w{0 1 2 3 4 5 6 7 8 9}

  config.define_group :first  do |group|
	group.expected_coordinates = {x1: 70, y1: 0, x2: 580, y2: 60}
  end

  config.define_group :second  do |group|
    group.expected_coordinates = {x1: 70, y1: 65, x2: 580, y2: 120}
  end

=begin
      config.define_group :third  do |group|
        group.expected_coordinates = {x1: 70, y1: 130, x2: 580, y2: 180}
      end

      config.define_group :forth  do |group|
        group.expected_coordinates = {x1: 70, y1: 195, x2: 580, y2: 245}
      end

     config.define_group :fifth  do |group|
        group.expected_coordinates = {x1: 70, y1: 255, x2: 580, y2: 305}
      end

     config.define_group :sixth  do |group|
        group.expected_coordinates = {x1: 70, y1: 315, x2: 580, y2: 365}
      end

     config.define_group :seventh  do |group|
        group.expected_coordinates = {x1: 70, y1: 380, x2: 580, y2: 430}
      end

     config.define_group :eighth  do |group|
        group.expected_coordinates = {x1: 70, y1: 440, x2: 580, y2: 490}
      end

     config.define_group :nineth  do |group|
        group.expected_coordinates = {x1: 70, y1: 500, x2: 580, y2: 550}
      end
=end
end

@recognizer.file = @file
#
flagged_recognizer = @recognizer.flag_all_marks
flagged_recognizer.write("ss5-result(marks).png")
#

result = @recognizer.scan
gakuseki = ""

p result

result.each do |k, v|
	num = v[1][0]
	gakuseki = gakuseki + num
end

p 'result = ' + gakuseki