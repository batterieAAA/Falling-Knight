extends Control

#@onready var load_game_button = $CanvasLayer/Button
@onready var camera_2d = $Camera2D
@onready var canveslayer = $CanvasLayer
@onready var animation_player = $AnimationPlayer
@onready var music_animation_player = $AnimationPlayer2
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var tutorialpanel = $CanvasLayer/TutorialPanel
@onready var shoppanel = $CanvasLayer/ShopPanel
@onready var trophydot = $CanvasLayer/TrophyButton/Trophydot
@onready var settingpanel = $CanvasLayer/Panel
@onready var trophy_panel = $CanvasLayer/TrophyPanel
@onready var cosmetic_panel = $CanvasLayer/CosmeticPanel





func _ready():
	print("play fade in")
	music_animation_player.play("fade_in")
	SkinManager.load_game()
	updatespendablegold()
	if SkinManager.newtrophy == true:
		trophydot.show()
	

func updatespendablegold():
	$CanvasLayer/SpendableCoinLabel.text = str(SkinManager.spendablegold)

func _on_start_game_button_pressed():
	# Get the root node (or the node you want to shake)
	SoundManager.startbutton.play()
	SkinManager.save_game()
	animated_sprite_2d.knightidle = false
	canveslayer.queue_free()
	camera_2d.shake_screen()
	animation_player.play("intro")
	$AudioStreamPlayer.playing = true
	music_animation_player.play("outro")

func _on_quit_button_pressed():
	get_tree().quit()


func _on_bgmslider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_sf_xslider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("earthquake"), linear_to_db(value))


func _on_settings_pressed():
	tutorialpanel.hide()
	shoppanel.hide()
	trophy_panel.hide()
	cosmetic_panel.hide()
	SoundManager.chick_sound.play()
	$CanvasLayer/Panel.visible = !$CanvasLayer/Panel.visible
	$CanvasLayer/Panel/Label.text = "total coin: " + str(SkinManager.totalcoin)
	$CanvasLayer/Panel/Label2.text = "total Greenfruit: " + str(SkinManager.totalgreenfruit)
	$CanvasLayer/Panel/Label3.text = "total Godfruit: " + str(SkinManager.totalgodfruit)
	$CanvasLayer/Panel/Label4.text = "total Healfruit: " + str(SkinManager.totalhealfruit)
	

func _on_login_reward_pressed():
	animated_sprite_2d.sprite_frames = SkinManager.helmlessskin
	SkinManager.updatecurrentskin()

func _on_petthehorse_pressed():
	SkinManager.trophies["trophy10"]= true
	trophydot.show()
	SkinManager.save_game()

func _on_petthehorse_button_down():
	$Aibou.play("Pet")

func _on_petthehorse_button_up():
	$Aibou.play("Idle")

func _on_close_button_pressed():
	SoundManager.kochuksound.play()
	tutorialpanel.hide()

func _on_tuto_button_pressed():
	shoppanel.hide()
	trophy_panel.hide()
	cosmetic_panel.hide()
	settingpanel.hide()
	SoundManager.chick_sound.play()
	tutorialpanel.visible = !tutorialpanel.visible

func _on_master_volume_pressed():
	AudioServer.set_bus_mute(0, !AudioServer.is_bus_mute(0))

func _on_animation_player_animation_finished(intro):
		get_tree().change_scene_to_file("res://game.tscn")

func _on_reset_progress_pressed():
	SkinManager.reset_save_file()
	get_tree().change_scene_to_file("res://main_menu.tscn")



