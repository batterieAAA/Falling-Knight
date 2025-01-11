extends Node2D

var is_game_paused = false

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = !is_game_paused
	is_game_paused = !is_game_paused
