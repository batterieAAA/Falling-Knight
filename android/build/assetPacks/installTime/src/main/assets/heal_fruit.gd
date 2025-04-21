extends Area2D

@export var speed = 100.0


func _process(delta):
	# Move the coin upwards
	position.y -= speed * delta

signal healfruit_collected

func _on_coin_body_entered(body): 
	if body is CharacterBody2D: 
		emit_signal("healfruit_collected") 
		$GPUParticles2D.emitting = true
		SoundManager.power_up.play()
		SkinManager.totalhealfruit += 1
		if SkinManager.totalhealfruit == 5:
			SkinManager.trophies["trophy7"] = true
		queue_free() # Remove the coin from the scene

