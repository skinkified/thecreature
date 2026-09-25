extends Button

signal pressed_with_sprite(mySprite)
var spritePath = "res://professorokabe.png"

func _on_SpriteButton_pressed():
	emit_signal("pressed_with_sprite", spritePath)
