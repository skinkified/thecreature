extends Node2D

onready var animPlayer = $AnimationPlayer
onready var timer = $Timer
onready var sprite = $SpriteWrapper/Sprite
var myShape = PoolVector2Array()

func _ready():
	resize_sprite()

func resize_sprite():
	var sprite_size = sprite.texture.get_size()
	sprite.scale = Vector2(500/sprite_size.y, 500/sprite_size.y)
	myShape.push_back(Vector2(0, 0))#topleft
	myShape.push_back(Vector2(0, 500))#botleft
	myShape.push_back(Vector2(900, 500))#botright
	myShape.push_back(Vector2(900, 130))#toprightbox
	myShape.push_back(Vector2(sprite_size.x*sprite.scale.x, 130))#connection
	myShape.push_back(Vector2(sprite_size.x*sprite.scale.x, 0))#toprightcreature
	OS.set_window_mouse_passthrough(myShape)

func _on_Timer_timeout():
	animPlayer.play("RESET")

func _on_TextEdit_text_changed():
	if timer.is_stopped():
		animPlayer.play("squish")
		timer.start()
	else:
		animPlayer.play("RESET")
		animPlayer.play("squish")
		timer.start()

func _on_SpriteList_buttons_done(buttonArr):
	for button in buttonArr:
		button.connect("pressed_with_sprite", self, "_on_button_with_sprite")

func _on_button_with_sprite(mySprite):
	if mySprite != null:
		sprite.texture = mySprite
	resize_sprite()


func _on_Settings_width_changed(newWidth):
	myShape[2] = Vector2(250+newWidth, 500)
	myShape[3] = Vector2(250+newWidth, 130)
	OS.set_window_mouse_passthrough(myShape)
