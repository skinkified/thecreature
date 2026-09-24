extends Node2D

onready var width = $RichTextLabel/LineEdit
signal width_changed(newWidth)

func _ready():
	width.connect("enter_pressed", self, "_on_enter_pressed")

func toggle_editable(myBool):
	width.editable = myBool

func _on_enter_pressed():
	if width.get_text().is_valid_integer():
		var newWidth = int(width.get_text())
		if newWidth >= 250 and newWidth <= 900:
			OS.set_window_size(Vector2(newWidth, 600))
			emit_signal("width_changed", newWidth)

func _on_Button_pressed():
	toggle_editable(false)
	visible = false
