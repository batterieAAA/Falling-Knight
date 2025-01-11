extends Control

@onready var load_game_button = $CanvasLayer/Button
@onready var timer = $CanvasLayer/Timer
@onready var camera_2d = $Camera2D
@onready var button = $CanvasLayer/Button
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D




func _on_start_game_button_pressed():
	# Get the root node (or the node you want to shake)
	animated_sprite_2d.knightidle = false
	button.queue_free()
	timer.start()
	camera_2d.shake_screen()
	animation_player.play("intro")
	$AudioStreamPlayer.playing = true
	


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://game.tscn")

