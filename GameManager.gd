extends Node

@export var all_floor_data: Array[FloorData]
@onready var spawner = $"../Spawner" 
@onready var background = $"../CanvasLayer/ParallaxBackground"
@onready var player = $"../Knight"
@onready var platform_1 = $Platform1
@onready var platform_initial_position = platform_1.position
@onready var main_music = $"../MainMusic"
@onready var death_scene = $"../CanvasLayer2/DeathScene"
@onready var floor_label = $"../CanvasLayer2/FloorLabel"
@onready var label = $"../CanvasLayer2/Fruitreq"


var floorIndex = 0
var current_floor_data : FloorData
func _ready():
	init()

func switch_floor():
	platform_1.position = platform_initial_position
	player.reset_new_floor()
	floorIndex += 1
	if floorIndex == 1:
		SkinManager.trophies["trophy1"]= true
	if floorIndex == 2:
		SkinManager.trophies["trophy2"]= true
	if floorIndex == 3:
		SkinManager.trophies["trophy3"]= true
	if floorIndex == 4:
		SkinManager.trophies["trophy4"]= true
	if floorIndex == 5:
		SkinManager.trophies["trophy5"]= true
	
	init()
	
func init():
	floorlabel()
	if floorIndex >= all_floor_data.size(): 
		current_floor_data = all_floor_data[all_floor_data.size() - 1] 
	else: 
		current_floor_data = all_floor_data[floorIndex]
		
	# Use the properties
	var bg1 = background.get_node("ParallaxLayer/Sprite2D")
	bg1.modulate = current_floor_data.background_color
	var bg2 = background.get_node("ParallaxLayer2/Sprite2D")
	bg2.modulate = current_floor_data.background_color
	var bg3 = background.get_node("ParallaxLayer3/Sprite2D")
	bg3.modulate = current_floor_data.background_color
	var bg4 = background.get_node("ParallaxLayer4/Sprite2D")
	bg4.modulate = current_floor_data.background_color
	
	platform_1.modulate = current_floor_data.background_color

	$Timer.wait_time = current_floor_data.floor_spawn_time
	$Timer.start()
	spawner.initialize(current_floor_data, max(0,floorIndex - all_floor_data.size()))
	

func _on_timer_timeout():
	spawner.stop_spawn()
	player.can_interact = false
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(player, "position", Vector2(388, 119), 2.6) 
	tween.tween_property(platform_1, "position", Vector2(388, 135), 2.6) 
	if player.passreq >= current_floor_data.fruit_nb_required:
		player.animation_player.play("breakfloor")
		$Timer2.wait_time = 2.4
	else:
		$Timer2.wait_time = 2.6
	$Timer2.start()



func fruitcheck():
	if player.passreq <= current_floor_data.fruit_nb_required:
		label.text = str(player.passreq) + "/" + str(current_floor_data.fruit_nb_required)
	if player.passreq >= current_floor_data.fruit_nb_required:
		player.godray()

func _on_timer_2_timeout():
	var success = player.passreq >= current_floor_data.fruit_nb_required
	$Timer2.stop()
	if success:
		platform_1.animation_player.play("platformbreak")
		await get_tree().create_timer(1).timeout
		fruitcheck()
	if success:
		platform_1.nexttlevel()
		switch_floor()
		platform_1.animation_player.play("RESET")
		player.animation_player.play("RESET")
		spawner.resume_spawn()
		player.nogodray()
		floorlabel()
	else:
		player.die()

	player.can_interact = true


func _on_main_music_finished():
	$"../MainMusic2".play()

func _on_main_music_2_finished():
	$"../MainMusic".play()

func floorlabel():
	floor_label.modulate = Color(1, 1, 1, 1)
	floor_label.text = "Level: " + str(floorIndex + 1)
	var tween = create_tween()
	tween.tween_property(floor_label, "modulate", Color(0, 0, 0, 0), 2)
	tween.set_ease(Tween.EASE_IN_OUT)
