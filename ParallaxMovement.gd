extends ParallaxBackground

@export var speed = Vector2(50, 0)  # Speed of the parallax movement

func _process(delta):
	for layer in get_children():
		if layer is ParallaxLayer:
			layer.motion_offset += speed * delta
