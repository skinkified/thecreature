extends Node2D

onready var animPlayer = $AnimationPlayer
onready var timer = $Timer
onready var sprite = $Sprite

func _ready():
	resize_sprite()

func resize_sprite():
	var sprite_size = sprite.texture.get_size()
	sprite.scale = Vector2(500/sprite_size.y, 500/sprite_size.y)

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
