extends Node

@export var all_floor_data: Array[FloorData]
@onready var spawner = $"../Spawner" 
@onready var background = $"../CanvasLayer/ParallaxBackground"

var floorIndex = 0

func _ready():
	init()

func switch_floor():
	floorIndex += 1
	init()
	
func init():
	var floor_data : FloorData
	if floorIndex >= all_floor_data.size(): 
		floor_data = all_floor_data[all_floor_data.size() - 1] 
	else: 
		floor_data = all_floor_data[floorIndex]
		
	# Use the properties
	var bg1 = background.get_node("ParallaxLayer/Sprite2D")
	bg1.modulate = floor_data.background_color
	var bg2 = background.get_node("ParallaxLayer2/Sprite2D")
	bg2.modulate = floor_data.background_color
	var bg3 = background.get_node("ParallaxLayer3/Sprite2D")
	bg3.modulate = floor_data.background_color
	var bg4 = background.get_node("ParallaxLayer4/Sprite2D")
	bg4.modulate = floor_data.background_color
	$Timer.wait_time = floor_data.time_interval
	$Timer.start()
	spawner.initialize(floor_data)

func _on_timer_timeout():
	switch_floor()
