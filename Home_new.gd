extends Node2D

onready var settings = $Settings
onready var height = $Settings/ColorRect/RichTextLabel2/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
	var screenSize = OS.get_screen_size()
	OS.set_window_position(Vector2(0, screenSize.y-500))
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("ui_toggle_front"):
		OS.set_window_always_on_top(true)
	if event.is_action_pressed("ui_toggle_back"):
		OS.set_window_always_on_top(false)
	if event.is_action_pressed("ui_settings"):
		settings.set_visible(true)
		settings.toggle_editable(true)
