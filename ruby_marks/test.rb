imageFiles = []

Dir::glob("./rsc/*.jpg").each {|f|
	imageFiles.push(f)
}

p imageFiles