class Conf
  def OMRsettings(hoge)

    @recognizer = hoge
    # Configuring the document aspects
    @recognizer.configure do |config|
      config.threshold_level = 50
      config.edge_level = 3
      config.default_expected_lines = 1
      config.default_block_width_tolerance = 25
      config.default_block_height_tolerance = 25
      config.default_mark_height = 23
      config.default_mark_width = 23
      config.default_distance_between_marks = 23
      config.default_marks_options = %w{0 1 2 3 4 5 6 7 8 9}
      startx = 35
      endx = 290
      starty = 5
      betweeny = 30

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