extends Area2D

@export var speed = 100.0



func _physics_process(delta):
	# Move the coin upwards
	position.y -= speed * delta



signal enemy_touched 

func _on_coin_body_entered(body): 

	print("ouch")

	if body is CharacterBody2D: 
		emit_signal("enemy_touched") 




