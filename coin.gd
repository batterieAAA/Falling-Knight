extends Node2D

@export var speed = 100.0

func _process(delta):
	# Move the coin upwards
	position.y -= speed * delta
