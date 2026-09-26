extends RichTextLabel

signal buttons_done(butonArr)

var textureArr = []
var buttonArr = []
var buttonY = 30

func _ready():
	var dir = Directory.new()
	if dir.open("user://sprites") == OK:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			#handle animation folders
			if dir.current_is_dir():
				var newDir = Directory.new()
				if newDir.open("user://sprites/" + fileName) == OK:
					var newFileName = newDir.list_dir_begin()
					newFileName = newDir.get_next()
					var myAnim = [fileName]
					var i = 0
					while newFileName != "":
						if newFileName == str(i) + ".png":
							myAnim.append(newFileName)
							i += 1
						newFileName = newDir.get_next()
					if myAnim.size() == 4:
						textureArr.append(myAnim)
			#handle single sprites
			elif fileName.split(".")[-1] == "png":
				textureArr.append(fileName)
			fileName = dir.get_next()
		make_buttons()
		emit_signal("buttons_done", buttonArr)

func make_buttons():
	for tex in textureArr:
		var newButton = load("res://SpriteButton.tscn")
		newButton = newButton.instance()
		newButton.rect_position.y = buttonY
		buttonY += 30
		if tex is Array:
			newButton.text = tex[0]
			for i in range(1,4):
				var texture = ImageTexture.new()
				var image = Image.new()
				print("user://sprites/" + tex[0] + "/" + tex[i])
				print(i)
				image.load("user://sprites/" + tex[0] + "/" + tex[i])
				texture.create_from_image(image)
				match i:
					1:
						newButton.spritePath0 = texture
					2:
						newButton.spritePath1 = texture
					3:
						newButton.spritePath2 = texture
			add_child(newButton)
			buttonArr.append(newButton)
		else:
			newButton.text = tex.split("/")[-1].split(".")[0]
			var texture = ImageTexture.new()
			var image = Image.new()
			image.load("user://sprites/" + tex)
			texture.create_from_image(image)
			newButton.spritePath0 = texture
			newButton.spritePath1 = texture
			newButton.spritePath2 = texture
			add_child(newButton)
			buttonArr.append(newButton)
