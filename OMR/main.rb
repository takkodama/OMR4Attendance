#encoding: UTF-8

$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'bundler/setup'
require 'ruby_marks'
require 'conf'
require 'cut_jpg'
require 'read_marks'
require 'write_csv'
require 'write_pdf'

results = []
filelist = []
n = 0
sourcedir = '00 src'
markdir = '01 id'
markeddir = '04 marked'
outputdir = '10 output'
thumb = ARGV[0] #jpg thumb thumb: SAMPLE
startx = ARGV[1].to_i #sample: 2700
starty = ARGV[2].to_i #sample: 1060
endx = ARGV[3].to_i #sample: 4370
endy = ARGV[4].to_i #sample: 2640


#0 CUT Files
imageFiles_src = Dir::glob("./#{sourcedir}/#{thumb}*.jpg")
jpg = CutJpg::new
img = Magick::ImageList.new

imageFiles_src.each do |filepath|
  filelist.push(filepath[/(\w+).jpg/, 1])
  img.read(filepath){self.density = 144}.first

  # Marksheet Area
  jpg.resizecutting(img, filelist[n], markdir, startx, starty, endx, endy, 300, 284) #300=resizedx, 284=resizedy
  # Comment Area
  jpg.cutting(img, filelist[n], '02 key', 0, 2940, img.columns, 4450) #sx, sy, ex, ey
  jpg.cutting(img, filelist[n], '03 com', 0, 4740, img.columns, 5710) #sx, sy, ex, ey
  n += 1
end
#p filelist

#1 SET OMRCONFIG
@recognizer = RubyMarks::Recognizer.new
conf = Conf::new(@recognizer)
conf.OMRsettings(25, 23, 30, 284, 5, 30) #OMRsettings(tolerance, size, startx, endx, starty, betweeny)

#2 READ Marks
marks = ReadMarks::new(@recognizer)
marks.read(thumb, markdir, markeddir, filelist, results)

#3 WRITE Results
csv = WriteCSV::new
csv.write("./#{outputdir}/#{thumb}results.csv", results)

pdf = WritePDF::new
pdf.write("./#{outputdir}/#{thumb}keywords.pdf", "./02 key/#{thumb}*.jpg")
pdf.write("./#{outputdir}/#{thumb}comments.pdf", "./03 com/#{thumb}*.jpg")

