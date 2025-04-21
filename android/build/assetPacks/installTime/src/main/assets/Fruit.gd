extends Area2D

@export var speed = 100.0
@onready var timer = $Timer
@onready var sprite = $AnimatedSprite2D
@onready var gpu_particles_2d = $GPUParticles2D



func _process(delta):
	# Move the coin upwards
	position.y -= speed * delta

signal fruit_collected

func _on_coin_body_entered(body): 
	if body is CharacterBody2D: 
		set_deferred("monitoring", false)
		set_deferred("monitorable", false)
		emit_signal("fruit_collected") 
		SoundManager.power_up.play()
		SkinManager.totalgreenfruit += 1
		if SkinManager.totalgreenfruit == 100:
			SkinManager.trophies["trophy9"] = true
		timer.start()
		sprite.visible = false
		gpu_particles_2d.emitting = true




func _on_timer_timeout():
	queue_free()
