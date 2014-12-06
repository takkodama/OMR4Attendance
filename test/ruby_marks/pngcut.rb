require 'rubygems'
require 'RMagick'

img = Magick::Image.read('png/1121-1.png'){self.density = 144}.first
tmp = img.crop(2830, 750, 1700, 1600)
tmp.write('crop1.png')
stu_id = tmp.resize(596, 564)
stu_id.write('rcrop1.png')
