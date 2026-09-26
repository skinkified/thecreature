extends TextEdit

onready var width = $"../Settings"
onready var outline0 = load("res://mplus0.tres")
onready var outline1 = load("res://mplus1.tres")
var dark = Color("#131313")
var light = Color("#ffffff")
var mode = 0

func _ready():
	width.connect("width_changed", self, "_on_width_changed")

func _on_width_changed(newWidth):
	rect_size.x = newWidth - 250

func _on_Color_pressed():
	if mode == 0:
		set_deferred("custom_colors/font_color", light)
		set_deferred("custom_fonts/font", outline1)
		mode = 1
	else:
		set_deferred("custom_colors/font_color", dark)
		set_deferred("custom_fonts/font", outline0)
		mode = 0
