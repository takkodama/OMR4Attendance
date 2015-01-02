$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'ruby_marks'

class ReadMarks

  attr_reader :recognizer

  def initialize(recognizer)
    @recognizer = recognizer
  end

  def read(markdir, markeddir, filename, results)
  	m = 0
	imageFiles_id = Dir::glob("./#{markdir}/*.jpg")

	imageFiles_id.each do |filepath|
	  # Instantiate the Recognizer
	  @recognizer.file = filepath
	  id = ""
	  # To check reading marks correctly
	  flagged_recognizer = @recognizer.flag_all_marks
  	  flagged_recognizer.write("./#{markeddir}/" + filename[m] + ".jpg")
	  flagged_recognizer.destroy!
	  m += 1

	  # Put characters
	  result = @recognizer.scan
	  result.each do |k, v|
	    if v[1][0] != nil
	    	num = v[1][0]
	    else
	    	num = '?'
	    end
	  id += num
	  end

	  # Show and Push results
	  results.push([m, id])
	  printf("%03d %s\n", m, id)
	end

  end
end