require 'RMagick'

pdf_file_name = "assets/1row.pdf"
im = Magick::Image.read(pdf_file_name)

im.write(pdf_file_name + ".png")