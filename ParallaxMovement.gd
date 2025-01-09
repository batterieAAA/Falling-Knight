extends ParallaxBackground

@export var speed = Vector2(50, 0)  # Speed of the parallax movement
var is_paused = false  # Boolean to control motion

func _process(delta):
	if not is_paused:
		for layer in get_children():
			if layer is ParallaxLayer:
				layer.motion_offset += speed * delta

func pause():
	is_paused = true

func play():
	is_paused = false
