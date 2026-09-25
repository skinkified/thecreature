extends Node2D

onready var animPlayer = $AnimationPlayer
onready var timer = $Timer
onready var sprite = $SpriteWrapper/Sprite
onready var test = $CollisionPolygon2D
var myShape = PoolVector2Array()
var myHeight = 500

func _ready():
	resize_sprite(myHeight)

func resize_sprite(newHeight):
	if myHeight <= 600: 
		myHeight = newHeight
		var sprite_size = sprite.texture.get_size()
		sprite.scale = Vector2(myHeight/sprite_size.y, myHeight/sprite_size.y)
		myShape = PoolVector2Array()
		myShape.push_back(Vector2(0, 0))#topleft
		myShape.push_back(Vector2(0, myHeight))#botleft
		myShape.push_back(Vector2(900, myHeight))#botright
		myShape.push_back(Vector2(900, 130))#toprightbox
		myShape.push_back(Vector2(sprite_size.x*sprite.scale.x, 130))#connection
		myShape.push_back(Vector2(sprite_size.x*sprite.scale.x, 0))#toprightcreature
		test.polygon = myShape
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
	resize_sprite(myHeight)

func _on_Settings_width_changed(newWidth):
	#idk why this isnt working
	if newWidth >= myShape[-1].x:
		myShape[2] = Vector2(newWidth, myHeight)
		myShape[3] = Vector2(newWidth, 130)
	else:
		myShape[2] = Vector2(myShape[-1].x+500, myHeight)
		myShape[3] = Vector2(myShape[-1].x+500, 130)
	test.polygon = myShape
	OS.set_window_mouse_passthrough(myShape)
