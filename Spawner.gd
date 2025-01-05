extends Area2D

@onready var player = $"/root/Game/Knight"
#Preload the item scene
var item_preload = preload("res://coin.tscn")
var fruit_preload = preload("res://fruit.tscn")
var enemy_preload = preload("res://obstacle.tscn")
#Define the interval (in seconds) between spawns
@export var spawn_interval = randi_range(1, 2)


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

	# Connect the coin_collected signal to the player 
	item.connect("coin_collected", Callable(player, "_on_coin_collected"))
	add_child(item)



func _on_timer_timeout():
	var fruit = fruit_preload.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	
	fruit.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	fruit.connect("fruit_collected", Callable(player, "_on_fruit_collected"))
	add_child(fruit)
	
	var enemy = enemy_preload.instantiate()
	enemy.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	enemy.connect("enemy_touched", Callable(player, "_on_enemy_touched"))
	add_child(enemy)
	
	
