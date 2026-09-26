extends Node2D

onready var animPlayer = $AnimationPlayer
onready var timer = $Timer
onready var timer2 = $Timer2
onready var sprite = $SpriteWrapper/Sprite
var myShape = PoolVector2Array()
var myHeight = 500
var del = false
var tex0
var tex1
var tex2

func _ready():
	resize_sprite(myHeight)
	tex0 = load("res://0.png")
	tex1 = load("res://1.png")
	tex2 = load("res://2.png")
	sprite.texture = tex0

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
		sprite.global_position = Vector2(sprite_size.x*sprite.scale.x*.5, myHeight*.5)
		OS.set_window_mouse_passthrough(myShape)

func _input(event):
	if event.is_action_pressed("ui_del"):
		del = true
	elif event.is_action_released("ui_del"):
		del = false

func _on_TextEdit_text_changed():
	if del:
		sprite.texture = tex2
	else:
		sprite.texture = tex1
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

func _on_button_with_sprite(mySprite0, mySprite1, mySprite2):
	if mySprite0 != null and mySprite1 != null and mySprite2 != null:
		tex0 = mySprite0
		tex1 = mySprite1
		tex2 = mySprite2
	sprite.texture = tex0
	resize_sprite(myHeight)

func _on_AnimationPlayer_animation_finished(_anim_name):
	timer2.start()

func _on_Timer2_timeout():
	if !animPlayer.is_playing():
		sprite.texture = tex0

func _on_Settings_width_changed(newWidth):
	#idk why this isnt working
	if OS.get_window_size().x < myShape[-1].x:
		OS.set_window_size(Vector2(myShape[-1].x, 600))
	if newWidth >= myShape[-1].x:
		myShape[2] = Vector2(newWidth, myHeight)
		myShape[3] = Vector2(newWidth, 130)
	else:
		myShape[2] = Vector2(900, myHeight)
		myShape[3] = Vector2(900, 130)
	OS.set_window_mouse_passthrough(myShape)
