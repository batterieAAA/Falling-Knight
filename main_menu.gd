extends Control

@onready var load_game_button = $CanvasLayer/Button
@onready var usernameTextBox = $CanvasLayer/LineEdit

func _ready():
	load_game_button.connect("pressed", Callable(self, "_on_start_game_button_pressed"))
	load_preferences()

func _on_start_game_button_pressed():
	save_preferences()
	get_tree().change_scene_to_file("res://game.tscn")

func save_preferences():
	var config = ConfigFile.new()
	config.set_value("username", "username", usernameTextBox.text)
	config.save("user://username.cfg")

func load_preferences():
	var config = ConfigFile.new()
	if config.load("user://username.cfg") == OK:
		var username = config.get_value("username", "username", "username")
		usernameTextBox.text = username
