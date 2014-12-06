require 'rubygems'
require 'RMagick'

img = Magick::ImageList.new("./pdf/5pages.pdf"){self.density = 144}
img.each_with_index{ |img,i| img.write "#{i.to_s}.png" }

p "successfly finished!"