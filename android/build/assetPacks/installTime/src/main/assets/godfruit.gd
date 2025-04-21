extends Area2D

@export var speed = 100.0



func _process(delta):
	# Move the coin upwards
	position.y -= speed * delta
	

signal godfruit_collected

func _on_coin_body_entered(body): 
	if body is CharacterBody2D: 
		emit_signal("godfruit_collected") 
		SkinManager.totalgodfruit += 1
		SoundManager.power_up.play()
		if SkinManager.totalgodfruit == 5:
			SkinManager.trophies["trophy8"] = true
		queue_free() # Remove the coin from the scene

