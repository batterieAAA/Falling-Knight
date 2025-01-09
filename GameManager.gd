extends Node

@export var all_floor_data: Array[FloorData]
@onready var spawner = $"../Spawner" 
@onready var background = $"../CanvasLayer/ParallaxBackground"
@onready var player = $"../Knight"
@onready var platform_1 = $Platform1

var floorIndex = 0
var current_floor_data : FloorData
func _ready():
	init()

func _process(delta):
	fruitcheck()

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
	var tween = create_tween()
	tween.tween_property(platform_1, "position", Vector2(439, 59), 0.5)
	if player.nbFruit >= current_floor_data.fruit_nb_required:
		switch_floor()
	else:
		player.die()

func fruitcheck():
	if player.nbFruit >= current_floor_data.fruit_nb_required:
		player.godray()
	else:
		player.nogodray()
