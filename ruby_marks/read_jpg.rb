$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'bundler/setup'
require 'ruby_marks'
require 'cut_jpg'
require 'settings'
require 'write_csv'
require 'com2pdf'

#class ReadJpg
    n = 0
    results = []

    #Add all files in stu_id folder to imageFiles list
    imageFiles = Dir::glob("./01 id/*.jpg")

    imageFiles.each do |filepath|

      # Instantiate the Recognizer
      @recognizer.file = filepath
      id = ""
      n += 1
      filename = filepath[/(\w+)\W+(\w+).jpg/, 1]

      # To check reading marks correctly
      flagged_recognizer = @recognizer.flag_all_marks
      flagged_recognizer.write('./04 marked/' + filename + '-marked.jpg')
      flagged_recognizer.destroy!

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
      results.push([n, id])
      printf("%03d %s\n", n, id)
    end

    csv = WriteCSV.new
    csv.write('GS1224results.csv', results)

    pdf = Com2Pdf.new
    pdf.write('GS1224comments.pdf')
#end

