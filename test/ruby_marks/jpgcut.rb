require 'rubygems'
require 'RMagick'

startx = 2770
starty = 950
endx = 4460
endy = 2540
n = 0
imageFiles = []

#rscフォルダ内の全jpgファイルを吸い上げる
Dir::glob("./rsc/*.jpg").each {|f|
	imageFiles.push(f)
}

img = Magick::ImageList.new
imageFiles.each do |jpg|
	n += 1
	img.read(jpg){self.density = 144}.first
	croped_img = img.crop(startx, starty, endx - startx, endy - starty)
	stu_id = croped_img.resize(600, 564)
	stu_id.write('./stu_id/stu_id' + n.to_s + '.jpg')
	stu_id.destroy!
end # imageFiles.each

=begin
img = Magick::Image.read('./jpg/sample-1.jpg'){self.density = 144}.first
croped_img = img.crop(startx, starty, endx - startx, endy - starty)
stu_id = croped_img.resize(600, 564)
stu_id.write('stu_id1.jpg')
stu_id.destroy!
=end

p "Files are wroten!"
