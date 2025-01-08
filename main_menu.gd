extends Control

@onready var load_game_button = $CanvasLayer/Button


func _ready():
	load_game_button.connect("pressed", Callable(self, "_on_start_game_button_pressed"))


func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")
