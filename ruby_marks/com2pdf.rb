#!/usr/bin/env ruby
require 'rubygems'
require 'prawn'

class Com2Pdf
	def write(filename)
		imageFiles = Dir::glob("./03 com/*.jpg")

		Prawn::Document.generate(filename) do
		  text "-[Global South Lecture] Comments from Students-"
		  imageFiles.each do |filepath|
		    image(filepath,
		          :fit => [bounds.absolute_right - bounds.absolute_left,
		                   bounds.absolute_top - bounds.absolute_bottom]
               	 )
		  end
		end
	end
end