extends Area2D

@export var speed = 100.0




func _process(delta):
	# Move the coin upwards
	position.y -= speed * delta

signal fruit_collected

func _on_coin_body_entered(body): 
	if body is CharacterBody2D: 
		emit_signal("fruit_collected") 
		queue_free() # Remove the coin from the scene

