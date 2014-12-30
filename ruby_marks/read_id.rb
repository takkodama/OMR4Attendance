$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'bundler/setup'
require 'ruby_marks'
require 'jpgcut'
require 'settings'

imageFiles = ["./stu_id/stu_id1.jpg", "./stu_id/stu_id2.jpg", "./stu_id/stu_id3.jpg"]

imageFiles.each do |jpg|

# Instantiate the Recognizer
@recognizer.file = "./stu_id/stu_id1.jpg"

# To check reading marks correctly
flagged_recognizer = @recognizer.flag_all_marks
flagged_recognizer.write("./marked/stu_id1.jpg")
flagged_recognizer.destroy!

result = @recognizer.scan
gakuseki = ""

p result

result.each do |k, v|
if v[1][0] != nil
	num = v[1][0]
else
	num = '?'
end
gakuseki += num
end

p 'result = ' + gakuseki

end