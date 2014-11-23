require 'rubygems'
require 'RMagick'

img = Magick::Image.read('png/1121-1.png').first
stu_id = img.crop(2800, 550, 1750, 1800)
stu_id.write('crop1.png')  #=> 画像左上を起点としてx:500, y:200の位置からwidth:300, height:100のサイズで切り取り
