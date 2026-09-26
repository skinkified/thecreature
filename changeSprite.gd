extends Button

signal pressed_with_sprite(mySprite)
var spritePath0 = load("res://0.png")
var spritePath1 = load("res://1.png")
var spritePath2 = load("res://2.png")

func _on_SpriteButton_pressed():
	emit_signal("pressed_with_sprite", spritePath0, spritePath1, spritePath2)
