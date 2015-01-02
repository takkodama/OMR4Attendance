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

#0 CONFIG
@recognizer = RubyMarks::Recognizer.new
conf = Conf.new(@recognizer)
#OMRsettings(tolerance, size, startx, endx, starty, betweeny)
conf.OMRsettings(25, 23, 35, 290, 5, 30)

#1 CUT Files
imageFiles_src = Dir::glob("./#{sourcedir}/*.jpg")
jpg = CutJpg.new
img = Magick::ImageList.new

imageFiles_src.each do |filepath|
  filelist.push(filepath[/(\w+).jpg/, 1])
  img.read(filepath){self.density = 144}.first

  jpg.resizecutting(img, filelist[n], markdir, 2810, 830, 4500, 2410, 300, 287)
  jpg.cutting(img, filelist[n], '02 key', 0, 2750, 4962, 4250)
  jpg.cutting(img, filelist[n], '03 com', 0, 4580, 4962, 5550)
  n += 1
end
#p filelist

#2 READ Marks
marks = ReadMarks.new(@recognizer)
marks.read(markdir, markeddir, filelist, results)

#3 WRITE Results
csv = WriteCSV.new
csv.write("./#{outputdir}/results.csv", results)

pdf = WritePDF.new
pdf.write("./#{outputdir}/keywords.pdf", "./02 key/*.jpg")
pdf.write("./#{outputdir}/comments.pdf", "./03 com/*.jpg")

