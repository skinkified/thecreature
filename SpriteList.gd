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
			if !dir.current_is_dir() and fileName.split(".")[-1] == "png":
				textureArr.append(fileName)
			fileName = dir.get_next()
		make_buttons()
		emit_signal("buttons_done", buttonArr)

func make_buttons():
	for tex in textureArr:
		var newButton = load("res://SpriteButton.tscn")
		newButton = newButton.instance()
		newButton.text = tex.split("/")[-1].split(".")[0]
		newButton.rect_position.y = buttonY
		buttonY += 30
		var texture = ImageTexture.new()
		var image = Image.new()
		image.load("user://sprites/" + tex)
		texture.create_from_image(image)
		newButton.spritePath = texture
		add_child(newButton)
		buttonArr.append(newButton)
