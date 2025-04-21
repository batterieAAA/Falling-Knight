extends Panel

@onready var animation_player = $"../../AnimationPlayer"



func _on_music_pressed():
	AudioServer.set_bus_mute(0, !AudioServer.is_bus_mute(0))


func _on_restart_pressed():
	animation_player.play("main_menu_outro")
	await get_tree().create_timer(1).timeout
	
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_pressed():
	animation_player.play("main_menu_outro")
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
