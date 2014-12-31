$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'RMagick'
require "find"

id_startx = 2750
id_starty = 1050
id_endx = 4400
id_endy = 2630

key_startx = 500
key_starty = 2930
key_endx = 4615
key_endy = 4400

com_startx = 500
com_starty = 4730
com_endx = 4615
com_endy = 5700

imageFiles = []
n = 0

#Add all files in rsc folder to imageFiles list
imageFiles = Dir::glob("./00 src/*.jpg")

p imageFiles

img = Magick::ImageList.new
imageFiles.each do |filepath|
	n += 1
	filename = filepath[/(\w+)\W+(\w+).jpg/, 2]

	img.read(filepath){self.density = 144}.first
	id = img.crop(id_startx, id_starty, id_endx - id_startx, id_endy - id_starty)
	#id.write('./01 id/' + filename + '-id(origin).jpg')

	resized_id = id.resize(300, 287)
	resized_id.write('./01 id/' + filename + '-id.jpg')
	id.destroy!
	resized_id.destroy!

	key = img.crop(key_startx, key_starty, key_endx - key_startx, key_endy - key_starty)
	key.write('./02 key/' + filename + '-key.jpg')
	key.destroy!

	com = img.crop(com_startx, com_starty, com_endx - com_startx, com_endy - com_starty)
	com.write('./03 com/' + filename + '-com.jpg')
	com.destroy!
end # imageFiles.each

=begin
img = Magick::Image.read('./jpg/sample-1.jpg'){self.density = 144}.first
croped_img = img.crop(startx, starty, endx - startx, endy - starty)
stu_id = croped_img.resize(600, 564)
stu_id.write('stu_id1.jpg')
stu_id.destroy!
=end

p "Files are wroten!"
