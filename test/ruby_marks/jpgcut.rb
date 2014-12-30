require 'rubygems'
require 'RMagick'

img = Magick::Image.read('./jpg/sample.jpg'){self.density = 144}.first
startx = 2770
starty = 950
endx = 4460
endy = 2540
tmp = img.crop(startx, starty, endx - startx, endy - starty)
stu_id = tmp.resize(600, 564)
stu_id.write('rcrop1.jpg')

p "Files are wroten!"
