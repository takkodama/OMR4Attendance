$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'bundler/setup'
require 'ruby_marks'
require 'cut_jpg'
require 'conf'
require 'write_csv'
require 'com2pdf'

results = []
filename = []
n = 0
m = 0

#1 CUT
imageFiles_src = Dir::glob("./00 src/*.jpg")
jpg = CutJpg.new
img = Magick::ImageList.new

imageFiles_src.each do |filepath|
  filename.push(filepath[/(\w+).jpg/, 1])
  img.read(filepath){self.density = 144}.first

  jpg.resizecutting(img, filename[n], '01 id', 2810, 830, 4500, 2410, 300, 287)
  jpg.cutting(img, filename[n], '02 key', 0, 2750, 4962, 4250)
  jpg.cutting(img, filename[n], '03 com', 0, 4580, 4962, 5550)
  n += 1
end

p filename

#2 READ Marks
imageFiles_id = Dir::glob("./01 id/*.jpg")

imageFiles_id.each do |filepath|
  # Instantiate the Recognizer
  @recognizer.file = filepath
  id = ""
  # To check reading marks correctly
  flagged_recognizer = @recognizer.flag_all_marks
  flagged_recognizer.write('./04 marked/' + filename[m] + '.jpg')
  flagged_recognizer.destroy!
  m += 1

  # Put characters
  result = @recognizer.scan
  result.each do |k, v|
    if v[1][0] != nil
    	num = v[1][0]
    else
    	num = '?'
    end
  id += num
  end

  # Show and Push results
  results.push([m, id])
  printf("%03d %s\n", m, id)
end

#3 WRITE Results
csv = WriteCSV.new
csv.write('./10 output/results.csv', results)

pdf = Com2Pdf.new
pdf.write('./10 output/keywords.pdf', "./02 key/*.jpg")
pdf.write('./10 output/comments.pdf', "./03 com/*.jpg")

