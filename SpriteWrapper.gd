extends Sprite

export var pos_delta = Vector2.ZERO
var rest_position = position

func _process(_delta):
	global_position = rest_position + pos_delta
