extends Node

@export var floor_data: FloorData
@onready var spawner = $"../Spawner" 
@onready var background = $"../CanvasLayer/ParallaxBackground"

func _ready():
	# Use the properties
	var bg1 = background.get_node("ParallaxLayer/Sprite2D")
	bg1.texture = floor_data.background_textures[0]
	var bg2 = background.get_node("ParallaxLayer2/Sprite2D")
	bg2.texture = floor_data.background_textures[1]
	var bg3 = background.get_node("ParallaxLayer3/Sprite2D")
	bg3.texture = floor_data.background_textures[2]
	var bg4 = background.get_node("ParallaxLayer4/Sprite2D")
	bg4.texture = floor_data.background_textures[3]
	
	spawner.initialize(floor_data)
