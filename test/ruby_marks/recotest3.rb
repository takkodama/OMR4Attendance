   

class RubyMarks::RecognizerTest < Test::Unit::TestCase
  def setup
    @file = 'assets/ss5.png'
    @recognizer = RubyMarks::Recognizer.new
    @positions = {}
    @positions[:marked_position] = {x: 205, y: 35}
    @positions[:unmarked_position] = {x: 100, y: 130}

    @recognizer.configure do |config|
      config.threshold_level = 70
      config.edge_level = 3
      config.default_expected_lines = 1
      config.default_block_width_tolerance = 50
      config.default_block_height_tolerance = 50
      config.default_mark_height = 50
      config.default_mark_width = 50
      config.default_distance_between_marks = 50
      config.default_marks_options = %w{0 1 2 3 4 5 6 7 8 9}

      config.define_group :first  do |group|
        group.expected_coordinates = {x1: 70, y1: 5, x2: 575, y2: 60}
      end

      config.define_group :second  do |group|
        group.expected_coordinates = {x1: 70, y1: 70, x2: 575, y2: 120}
      end

      config.define_group :third  do |group|
        group.expected_coordinates = {x1: 70, y1: 130, x2: 575, y2: 180}
      end

      config.define_group :forth  do |group|
        group.expected_coordinates = {x1: 70, y1: 195, x2: 575, y2: 245}
      end

     config.define_group :fifth  do |group|
        group.expected_coordinates = {x1: 70, y1: 255, x2: 575, y2: 305}
      end

     config.define_group :sixth  do |group|
        group.expected_coordinates = {x1: 70, y1: 315, x2: 575, y2: 365}
      end

     config.define_group :seventh  do |group|
        group.expected_coordinates = {x1: 70, y1: 380, x2: 575, y2: 430}
      end

     config.define_group :eighth  do |group|
        group.expected_coordinates = {x1: 70, y1: 440, x2: 575, y2: 490}
      end

     config.define_group :nineth  do |group|
        group.expected_coordinates = {x1: 70, y1: 500, x2: 575, y2: 550}
      end


    end

    @recognizer.file = @file

  end


  def test_should_initialize_a_recognizer_with_a_valid_file
    assert_equal @file, @recognizer.filename
  end

=begin
  def test_should_pass_the_configuration_to_recognizer_config
    @recognizer.configure do |config|
      config.threshold_level = 70
    end
    assert_equal 70, @recognizer.config.threshold_level
  end


  def test_should_get_the_default_configuration_of_config_in_group
    @recognizer.configure do |config|
      config.default_marks_options = %w{0 1 2 3 4}

      config.define_group :first
    end
    assert_equal %w{0 1 2 3 4}, @recognizer.groups[:first].marks_options
  end

  def test_should_get_the_configuration_defined_in_group
    @recognizer.configure do |config|
      config.default_marks_options = %w{0 1 2 3 4}
      config.define_group :first do |group|
        group.marks_options = %w{0 1 2}
      end
    end
    assert_equal %w{0 1 2}, @recognizer.groups[:first].marks_options
  end
=end

  def test_should_return_a_file_with_a_position_flagged
    flagged_document = @recognizer.flag_position @positions[:marked_position]
    assert_equal Magick::Image, flagged_document.class

    temp_filename = "assets/ss2-result1.png"
    File.delete(temp_filename) if File.exist?(temp_filename)
    flagged_document.write(temp_filename)
  end

=begin

  def test_should_recognize_marked_position
    @recognizer.detect_groups
    group = @recognizer.groups[:first]
    line = group.marks[1]
    mark = line.first
    assert mark.marked?, "The position wasn't recognized as marked"
  end

  def test_should_recognize_not_marked_position
    @recognizer.detect_groups
    group = @recognizer.groups[:first]
    line = group.marks[2]
    mark = line.first
    assert mark.unmarked?, "The position wasn't recognized as unmarked"    
  end
=end

  def test_should_return_the_recognizer_with_all_marks_flagged
    flagged_recognizer = @recognizer.flag_all_marks
    assert_equal Magick::Image, flagged_recognizer.class

    temp_filename = "assets/ss5-result.png"
    File.delete(temp_filename) if File.exist?(temp_filename)
    flagged_recognizer.write(temp_filename)
  end


  def test_should_scan_the_recognizer_and_get_a_hash_of_marked_marks
    expected_hash = {
      first: {
        1 => ['2']
      },
      second: {
        1 => ['0']
      },
      third: {
        1 => ['0']
      },
      forth: {
        1 => ['0']
      },
      fifth: {
        1 => ['0']
      },
      sixth: {
        1 => ['0']
      },
      seventh: {
        1 => ['0']
      },
      eighth: {
        1 => ['0']
      },
      nineth: {
        1 => ['0']
      }
    }
    result = @recognizer.scan
    result.each_pair do |group, lines|
      lines.delete_if { |line, value| value.empty? }
    end

    result.delete_if { |group, lines| lines.empty? }
    assert_equal expected_hash, result
  end

=begin

  def test_should_make_watcher_raise_up
    @file = 'assets/ss2-failure.png'
    @recognizer.file = @file 

    @recognizer.add_watcher :incorrect_group_watcher

    @recognizer.scan
    assert @recognizer.raised_watchers.include?(:incorrect_group_watcher)
  end

  def test_should_make_timeout_watcher_raise_up  
    @recognizer.configure do |config|
      config.scan_timeout = 1
    end

    @recognizer.add_watcher :timed_out_watcher

    @recognizer.scan
    assert @recognizer.raised_watchers.include?(:timed_out_watcher)
  end
=end
end
