extends Area2D

#Preload the item scene
var item_preload = preload("res://coin.tscn")
#Define the interval (in seconds) between spawns
@export var spawn_interval = 1.0

func _ready():
	# Create and start a timer
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", self._on_timeout)

func _on_timeout():
	# Spawn a new item at a random position within the Area2D
	var item = item_preload.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	item.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	add_child(item)
