$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'RMagick'

id_startx = 2750
id_starty = 1075
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
Dir::glob("./rsc/*.jpg").each {|f|
	imageFiles.push(f)
}

p imageFiles

img = Magick::ImageList.new
imageFiles.each do |jpg|
	n += 1
	img.read(jpg){self.density = 144}.first
	stu_id = img.crop(id_startx, id_starty, id_endx - id_startx, id_endy - id_starty)
	#stu_id.write('./stu_id/stu_id_origin' + n.to_s + '.jpg')
	resized_stu_id = stu_id.resize(600, 565)
	resized_stu_id.write('./stu_id/stu_id' + n.to_s + '.jpg')
	stu_id.destroy!
	resized_stu_id.destroy!

	key = img.crop(key_startx, key_starty, key_endx - key_startx, key_endy - key_starty)
	key.write('./key/key' + n.to_s + '.jpg')
	key.destroy!

	com = img.crop(com_startx, com_starty, com_endx - com_startx, com_endy - com_starty)
	com.write('./com/com' + n.to_s + '.jpg')
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
