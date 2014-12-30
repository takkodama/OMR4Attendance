require 'rubygems'
require 'RMagick'

startx = 2770
starty = 950
endx = 4460
endy = 2540

img = Magick::Image.read('./jpg/sample-1.jpg'){self.density = 144}.first
croped_img = img.crop(startx, starty, endx - startx, endy - starty)
stu_id = croped_img.resize(600, 564)
stu_id.write('stu_id1.jpg')
stu_id.destroy!

p "Files are wroten!"
