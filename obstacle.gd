extends Area2D

@export var speed = 100.0
@onready var camera = $"../../Camera2D" 
var direction = randi_range(-1,1)



func _physics_process(delta):
	# Move the coin upwards
	position.y -= speed * delta
	position.x += speed * direction * delta
	self.scale.x = -1 if direction < 0 else 1



signal enemy_touched 

func _on_coin_body_entered(body): 

	print("ouch")

	if body is CharacterBody2D: 
		emit_signal("enemy_touched") 
		queue_free() # Remove the coin from the scene



func _on_timer_timeout():
	direction = randi_range(-1,1)
