extends Area2D

@onready var coinTimer = $CoinTimer
@onready var fruitTimer = $FruitTimer
@onready var enemyTimer = $EnemyTimer
@onready var player = $"/root/Game/Knight"
#Preload the item scene
var item_preload = preload("res://coin.tscn")
var fruit_preload = preload("res://fruit.tscn")
var enemy_preload = preload("res://obstacle.tscn")

func _on_coin_timer_timeout():
	# Spawn a new item at a random position within the Area2D
	var item = item_preload.instantiate()

	var area_extents = $CollisionShape2D.shape.extents
	item.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)

	# Connect the coin_collected signal to the player 
	item.connect("coin_collected", Callable(player, "_on_coin_collected"))
	coinTimer.wait_time = randf_range(1, 2)
	add_child(item)


func _on_fruit_timer_timeout():
	var fruit = fruit_preload.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	
	fruit.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	fruit.connect("fruit_collected", Callable(player, "_on_fruit_collected"))
	add_child(fruit)
	fruitTimer.wait_time = randf_range(1.5, 2.5)
	
func _on_enemy_timer_timeout():

	var enemy = enemy_preload.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	enemy.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	enemy.connect("enemy_touched", Callable(player, "_on_enemy_touched"))
	add_child(enemy)
	enemyTimer.wait_time = randf_range(1.5, 2.5)
	
