extends Control

@onready var heart1 = $Heart1
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3
@onready var shield1 = $Shield1


# Load your heart textures
var empty_heart_texture = preload("res://Assets/heart sprite/Heart - Empty.png")
var full_heart_texture = preload("res://Assets/heart sprite/Heart.png")



const MAX_HEALTH = 3

var health = MAX_HEALTH

func _ready():
	if SkinManager.boughtshield:
		shield1.visible = true

func update_shield():
	shield1.visible = false

func update_hearts(health):
	match health:
		3:
			heart1.texture = full_heart_texture
			heart2.texture = full_heart_texture
			heart3.texture = full_heart_texture
		2:
			heart1.texture = full_heart_texture
			heart2.texture = full_heart_texture
			heart3.texture = empty_heart_texture
		1:
			heart1.texture = full_heart_texture
			heart2.texture = empty_heart_texture
			heart3.texture = empty_heart_texture
		0:
			heart1.texture = empty_heart_texture
			heart2.texture = empty_heart_texture
			heart3.texture = empty_heart_texture
