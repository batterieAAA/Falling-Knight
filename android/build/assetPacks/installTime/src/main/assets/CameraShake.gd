extends Camera2D

var shake_intensity = 10.0
var shake_duration = 5
var shake_timer = 0.0
var original_position = Vector2.ZERO

func _ready():
	original_position = position

func shake_screen():
	shake_timer = shake_duration

func _process(delta):
	if shake_timer > 0:
		shake_timer -= delta
		var random_offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		position = original_position + random_offset
	else:
		position = original_position
