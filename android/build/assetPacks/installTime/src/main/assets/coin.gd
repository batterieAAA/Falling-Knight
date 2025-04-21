extends Area2D

@export var speed = 100.0
@onready var timer = $Timer
@onready var sprite = $AnimatedSprite2D
@onready var gpu_particles_2d = $GPUParticles2D

signal coin_collected

func _process(delta):
	# Move the coin upwards
	position.y -= speed * delta

func _on_coin_body_entered(body): 
	if body is CharacterBody2D: 
		set_deferred("monitoring", false)
		set_deferred("monitorable", false)
		emit_signal("coin_collected") 
		SoundManager.pick_coin.play()
		SkinManager.totalcoin +=1
		if SkinManager.totalcoin >= 100:
			SkinManager.trophies["trophy6"] = true
		timer.start()
		sprite.visible = false
		gpu_particles_2d.emitting = true


func _on_timer_timeout():
	queue_free()
