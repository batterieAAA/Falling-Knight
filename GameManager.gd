extends Node

@export var all_floor_data: Array[FloorData]
@onready var spawner = $"../Spawner" 
@onready var background = $"../CanvasLayer/ParallaxBackground"
@onready var player = $"../Knight"

var floorIndex = 0
var current_floor_data : FloorData
func _ready():
	init()

func switch_floor():
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
	

	$Timer.wait_time = current_floor_data.floor_spawn_time
	$Timer.start()
	spawner.initialize(current_floor_data)

func _on_timer_timeout():
	#TODO: Spawn le floor et check pour le nbFruit quand le body touche au floor
	if player.nbFruit >= current_floor_data.fruit_nb_required:
		switch_floor()
	else:
		player.die()
