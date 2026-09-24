extends Node2D

onready var sprite = $Professorokabe
onready var timer = $Timer
onready var label = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
	OS.set_window_position(Vector2(100, 500))

func _process(_delta):
		if Input.is_action_just_pressed("ui_type_row0") or Input.is_action_just_pressed("ui_type_row1") or \
		Input.is_action_just_pressed("ui_type_row2") or Input.is_action_just_pressed("ui_type_row3"):
			if timer.is_stopped():
				sprite.position -= Vector2(0, 100)
				timer.start()
			else:
				sprite.position += Vector2(0, 100)
				sprite.position -= Vector2(0, 100)
				timer.start()

func clean_input(inputText):
	print(inputText)
	if inputText == "BackSpace" and label.text.length() >= 1:
		label.text = label.text.substr(0, label.text.length()-1)
		return
	if inputText == "Enter":
		inputText = "\n"
	elif inputText == "Space":
		inputText = " "
	else:
		var textArr = inputText.split("+")
		if textArr[0] == "Shift" and textArr.size() > 1: 
			match (textArr[1]):
				"Comma":
					inputText = "<"
				"Period":
					inputText = ">"
				"Semicolon":
					inputText = ":"
				"Apostrophe":
					inputText = "\""
				_:
					if textArr[1].length() == 1:
						inputText = textArr[1]
					else:
						inputText = ""
		else: 
			match (inputText):
				"Comma":
					inputText = ","
				"Period":
					inputText = "."
				"Semicolon":
					inputText = ";"
				"Apostrophe":
					inputText = "'"
				_:
					if inputText.length() == 1:
						inputText = inputText.to_lower()
					else:
						inputText = ""
	label.text += inputText
	return

func _input(event):
	if event is InputEventKey and event.is_pressed() and !event.is_echo():
		clean_input(event.as_text())
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
func _on_Timer_timeout():
	sprite.position += Vector2(0, 100)
