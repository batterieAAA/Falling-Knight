extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 150

enum {FALL, RUN, DEATH}

var state = FALL

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Ensure the character stays within the viewport boundaries
	var viewport_rect = get_viewport_rect()

	position.x = clamp(position.x, 0, viewport_rect.size.x)
	position.y = clamp(position.y, 0, viewport_rect.size.y)
