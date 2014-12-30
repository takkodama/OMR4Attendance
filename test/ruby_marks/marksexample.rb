require 'rubygems'
require 'bundler/setup'
require 'ruby_marks'

# Instantiate the Recognizer
@file = 'ss6.jpg'
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
  startx = 975
  starty = 318
  betweenx = 1488 - startx
  betweeny = 378 - starty

  config.define_group :first  do |group|
	group.expected_coordinates = {x1: startx , y1: starty, x2: startx + betweenx, y2: starty + betweeny * 1}
  end

  p 'no.1 ...'

  config.define_group :second  do |group|
	group.expected_coordinates = {x1: startx , y1: starty + betweeny * 1, x2: startx + betweenx, y2: starty + betweeny * 2}
  end

  p 'no.2 ...'

  config.define_group :third  do |group|
 	group.expected_coordinates = {x1: startx , y1: starty + betweeny * 2, x2: startx + betweenx, y2: starty + betweeny * 3}
  end

  p 'no.3 ...'

  config.define_group :forth  do |group|
	group.expected_coordinates = {x1: startx , y1: starty + betweeny * 3, x2: startx + betweenx, y2: starty + betweeny * 4}
  end

  p 'no.4 ...'

 config.define_group :fifth  do |group|
	group.expected_coordinates = {x1: startx , y1: starty + betweeny * 4, x2: startx + betweenx, y2: starty + betweeny * 5}
  end

  p 'no.5 ...'

 config.define_group :sixth  do |group|
	group.expected_coordinates = {x1: startx , y1: starty + betweeny * 5, x2: startx + betweenx, y2: starty + betweeny * 6}
  end

  p 'no.6 ...'

 config.define_group :seventh  do |group|
	group.expected_coordinates = {x1: startx , y1: starty + betweeny * 6, x2: startx + betweenx, y2: starty + betweeny * 7}
  end

  p 'no.7 ...'

 config.define_group :eighth  do |group|
	group.expected_coordinates = {x1: startx , y1: starty + betweeny * 7, x2: startx + betweenx, y2: starty + betweeny * 8}
  end

  p 'no.8 ...'

 config.define_group :nineth  do |group|
	group.expected_coordinates = {x1: startx , y1: starty + betweeny * 8, x2: startx + betweenx, y2: starty + betweeny * 9}
  end

  p 'no.9 ...'

end

@recognizer.file = @file
#
flagged_recognizer = @recognizer.flag_all_marks
flagged_recognizer.write("ss6(marks).jpg")
#

result = @recognizer.scan
gakuseki = ""

p result

result.each do |k, v|
	if v[1][0] != nil
		num = v[1][0]
	else
		num = '?'
	end
	gakuseki = gakuseki + num
end

p 'result = ' + gakuseki