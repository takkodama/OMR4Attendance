#!/usr/bin/env ruby
require 'rubygems'
require 'prawn'

class WritePdf
	def write(pdf, jpgs)
		imageFiles = Dir::glob(jpgs)

		Prawn::Document.generate(pdf) do
		  text "-[Global South Lecture]- " + pdf[/(\w+).pdf/, 1]
		  imageFiles.each do |filepath|
		    image(filepath,
		          :fit => [bounds.absolute_right - bounds.absolute_left,
		                   bounds.absolute_top - bounds.absolute_bottom]
               	 )
		  end
		end
	end
end