extends RichTextLabel

var textureArr = []

func _ready():
	print("hello")
	var dir = Directory.new()
	if dir.open("user://sprites") == OK:
		print("hi")
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			print("owo")
			if !dir.current_is_dir() and fileName.split(".")[-1] == "png":
				print(fileName)
				textureArr.append(fileName)
		print(textureArr)
	else:
		print("An error occurred when trying to access the path.")
#		var file_name = dir.get_next()
#		while file_name != "":
#			if dir.current_is_dir():
#				print("Found directory: " + file_name)
#			else:
#				print("Found file: " + file_name)
#			file_name = dir.get_next()
#	else:
#		print("An error occurred when trying to access the path.")
