extends Area2D

# Export variables to adjust in the editor
@export var projectile_scene: PackedScene

@export var speed: float = 100.0

@onready var marker_2d = $Marker2D
@onready var player = get_node("/root/Game/Knight")
@onready var camera = get_node("/root/Game/Camera2D")
func _ready():
	set_process(true)

func _process(delta):
	position.y -= speed * delta

func shoot_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.position = marker_2d.position
	projectile.direction = (player.global_position - marker_2d.global_position).normalized()
	add_child(projectile)

signal enemy_touched

func _on_player_body_entered(body):
	print("ouch")
	if body is CharacterBody2D:
		emit_signal("enemy_touched")
		queue_free() # Remove the enemy from the scene


func _on_timer_timeout():
	shoot_projectile()

func _on_timer_2_timeout():
	queue_free()
