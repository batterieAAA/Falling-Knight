extends Area2D

@export var speed = 100.0
@onready var camera = $"../../Camera2D" 
var direction = randi_range(-1, 1)

func _physics_process(delta):
	# Move the coin upwards
	position.y -= speed * delta
	position.x += speed / 2 * direction * delta

	# Boundary checks
	# Ensure the character stays within the viewport boundaries, considering the zoom factor
	var camera_position = camera.global_position
	var viewport_size = get_viewport().get_visible_rect().size
	var zoom_factor = camera.zoom

	var half_width = (viewport_size.x / 2) / zoom_factor.x
	var min_x = camera_position.x - half_width
	var max_x = camera_position.x + half_width

	if global_position.x < min_x or global_position.x > max_x:
		direction = -direction

	self.scale.x = -1 if direction < 0 else 1

signal enemy_touched

func _on_coin_body_entered(body):
	if body is CharacterBody2D:
		emit_signal("enemy_touched")
		queue_free() # Remove the coin from the scene

func _on_timer_timeout():
	direction = randi_range(-1, 1)


func _on_timer_2_timeout():
	queue_free()
