extends Node

@export var all_floor_data: Array[FloorData]
@onready var spawner = $"../Spawner" 
@onready var background = $"../CanvasLayer/ParallaxBackground"
@onready var player = $"../Knight"
@onready var platform_1 = $Platform1
@onready var platform_initial_position = platform_1.position

var floorIndex = 0
var current_floor_data : FloorData
func _ready():
	init()

func _process(delta):
	fruitcheck()

func switch_floor():
	platform_1.position = platform_initial_position
	player.reset_new_floor()
	floorIndex += 1
	init()
	
func init():

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
	spawner.initialize(current_floor_data)

func _on_timer_timeout():
	player.can_interact = false
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(platform_1, "position", Vector2(439, 59), 1) 
	tween.tween_property(player, "position", Vector2(439, 59), 1) 

	print("timer2_start")
	$Timer2.wait_time = 1.2
	$Timer2.start()

func fruitcheck():
	if player.nbFruit >= current_floor_data.fruit_nb_required:
		player.godray()
	else:
		player.nogodray()

func _on_timer_2_timeout():
	$Timer2.stop()
	print("timer2_timeout")
	if player.nbFruit >= current_floor_data.fruit_nb_required:
		switch_floor()
	else:
		player.die()
	player.can_interact = true
