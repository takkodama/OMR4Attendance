require File.expand_path("../../test_helper", __FILE__)

class RubyMarks::RecognizerGridTest < Test::Unit::TestCase
  
  def setup 
    @file = 'assets/sheet_demo_grid.png'
    @recognizer = RubyMarks::Recognizer.new

    @recognizer.configure do |config| 

      config.scan_mode = :grid
      config.edge_level = 4
      config.default_expected_lines = 5
      config.intensity_percentual = 45
      config.default_mark_height = 26
      config.default_mark_width = 26
      config.auto_ajust_block_width = :right
      config.default_block_width_tolerance = 10

      config.define_group :um do |group|
        group.expected_coordinates = {x1: 135, y1: 220, x2: 260, y2: 350}
      end
    end

    @recognizer.file = @file

    file = @recognizer.file
    file.write("sheet_demo_grid3.png")
  end


  def test_should_return_the_recognizer_with_all_marks_flagged
    flagged_recognizer = @recognizer.flag_all_marks
    assert_equal Magick::Image, flagged_recognizer.class

    temp_filename = "sheet_demo_grid2.png"
    File.delete(temp_filename) if File.exist?(temp_filename)
    flagged_recognizer.write(temp_filename)    
  end

  def test_should_scan_the_recognizer_and_get_a_hash_of_marked_marks
    expected_hash = { 
      um: {  
        1 => ['A'],
        2 => ['A'],
        3 => ['D'],
        4 => ['B'],
        5 => ['B']
      }
    }
    result = @recognizer.scan
    result.each_pair do |group, lines|
      lines.delete_if { |line, value| value.empty? }
    end
    result.delete_if { |group, lines| lines.empty? }
    assert_equal expected_hash, result 
  end

end