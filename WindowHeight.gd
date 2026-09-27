extends LineEdit

signal enter_pressed()

func _input(event):
	if event.is_action_pressed("ui_enter"):
		emit_signal("enter_pressed")
