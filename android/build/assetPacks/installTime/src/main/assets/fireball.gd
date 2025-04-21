extends Area2D

 #Export variables to adjust in the editor
@export var speed: float = 100.0
@export var direction: Vector2 = Vector2(0, 0)


func _ready():
	set_process(true)
	var player = get_node("/root/Game/Knight")
	connect("enemy_touched", Callable(player, "_on_enemy_touched"))
#
func _process(delta):
	position.y -= speed * delta
	#position += direction * speed * delta
#

signal enemy_touched

func _on_player_body_entered(body):
	if body is CharacterBody2D:
		emit_signal("enemy_touched")
		queue_free() # Remove the coin from the scene



func _on_timer_timeout():
	queue_free() # Remove the coin from the scene
