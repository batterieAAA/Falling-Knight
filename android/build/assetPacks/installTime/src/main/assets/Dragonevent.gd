extends Area2D

# Export variables to adjust in the editor
@export var projectile_scene: PackedScene

@export var shooting: bool

@onready var marker_2d = $Marker2D
@onready var player = $"../Knight"

func _ready():
	set_process(true)

func _process(delta):
	if shooting:
		shoot_projectile()

func shoot_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.global_position = marker_2d.global_position  # Use global_position here
	projectile.direction = (player.global_position - marker_2d.global_position).normalized()
	get_tree().root.add_child(projectile)  # Add it to the root, not the parent node

signal enemy_touched

func _on_player_body_entered(body):
	if body is CharacterBody2D:
		emit_signal("enemy_touched")
		queue_free() # Remove the enemy from the scene


func _on_timer_timeout():
	shoot_projectile()

func _on_timer_2_timeout():
	queue_free()
