extends AnimatedSprite2D

var speed = 100
var direction = 0.0
var target_x = 0.0
var y_position = 0.0

var knightidle = true

func _ready():
	# Set the initial y position to the current position
	y_position = position.y
	# Start with an initial target x position
	target_x = get_random_x_position()

func _process(delta):
	if knightidle == true:
	# Move the character towards the target x position
		direction = sign(target_x - position.x)
		position.x += direction * speed * delta
		position.y = y_position  # Keep the y position constant

	# Check if the character has reached the target x position
		if position.distance_to(Vector2(target_x, y_position)) < 10:
			target_x = get_random_x_position()

	# Flip the sprite based on the direction
		flip_h = direction < 0

	# Play the walking animation
		play("walk")

func get_random_x_position():
	# Generate a random x position within the scene
	var screen_size = get_viewport_rect().size
	return randf_range(0, screen_size.x)


func updatecurrentskin():
	sprite_frames = SkinManager.currentskin
