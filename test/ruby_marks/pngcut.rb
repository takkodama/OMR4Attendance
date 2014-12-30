require 'rubygems'
require 'RMagick'

img = Magick::Image.read('./png/ss16.png'){self.density = 144}.first
startx = 2770
starty = 950
endx = 4460
endy = 2540
tmp = img.crop(startx, starty, endx - startx, endy - starty)
tmp.write('crop1.png')
stu_id = tmp.resize(600, 564)
stu_id.write('rcrop1.png')
