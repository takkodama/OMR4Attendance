$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'RMagick'

class CutJpg

	def resizecutting(img, filename, dirname, x1, y1, x2, y2, rx, ry)
		cut = img.crop(x1, y1, x2 - x1, y2 - y1)
		cut_resized = cut.resize(rx, ry)
		cut_resized.write('./' + dirname + '/' + filename + '.jpg')
		cut.destroy!
		cut_resized.destroy!
	end

	def cutting(img, filename, dirname, x1, y1, x2, y2)
		cut = img.crop(x1, y1, x2 - x1, y2 - y1)
		cut.write('./' + dirname + '/' + filename + '.jpg')
		cut.destroy!
	end

end