extends Area2D

@onready var coinTimer = $CoinTimer
@onready var fruitTimer = $FruitTimer
@onready var enemyTimer = $EnemyTimer
@onready var player = $"/root/Game/Knight"
@onready var healfruitTimer = $HealFruitTimer
@onready var godfruittimer = $GodFruitTimer


var item_preload = preload("res://coin.tscn")
var fruit_preload = preload("res://fruit.tscn")
var healfruit_preload = preload("res://heal_fruit.tscn")
var godfruit_preload = preload("res://godfruit.tscn")
var enemies: Array[PackedScene] = []
var minEnemySpawnTime: float
var maxEnemySpawnTime: float
var speed: float = 100
var timerMod: float = speed / 100

func _ready():
	$"../AnimationPlayer".play("main_menu_intro")
	await get_tree().create_timer(1).timeout
	set_timers()

func initialize(floorData: FloorData, floor_above_five: float):
	minEnemySpawnTime = floorData.min_enemy_spawn_interval
	maxEnemySpawnTime = floorData.max_enemy_spawn_interval
	enemies = floorData.enemy_scenes
	speed = floorData.speed + (25 * floor_above_five)
	enemyTimer.wait_time = randf_range(minEnemySpawnTime, maxEnemySpawnTime)
	enemyTimer.start()

func is_position_free(new_position: Vector2, margin: float = 50.0) -> bool:
	for child in get_children():
		if child is Area2D and child.position.distance_to(new_position) < margin:
			return false
	return true

func spawn_item(instance: PackedScene, timer: Timer, signal_name: String, target_callable: Callable, wait_time_range: Vector2):
	var item = instance.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	var new_position: Vector2
	var attempts = 0

	while attempts < 100:
		new_position = Vector2(
			randf_range(-area_extents.x, area_extents.x),
			randf_range(-area_extents.y, area_extents.y)
		)
		if is_position_free(new_position):
			break
		attempts += 1

	item.position = new_position
	item.speed = speed
	item.connect(signal_name, target_callable)
	add_child(item)
	timer.wait_time = randf_range(wait_time_range.x, wait_time_range.y)
	timer.start()

func _on_coin_timer_timeout():
	spawn_item(item_preload, coinTimer, "coin_collected", Callable(player, "_on_coin_collected"), Vector2(0.5 * timerMod, 1 * timerMod))

func _on_fruit_timer_timeout():
	spawn_item(fruit_preload, fruitTimer, "fruit_collected", Callable(player, "_on_fruit_collected"), Vector2(2.5, 2.5))

func _on_enemy_timer_timeout():
	var enemy_scene = enemies[randi() % enemies.size()]
	spawn_item(enemy_scene, enemyTimer, "enemy_touched", Callable(player, "_on_enemy_touched"), Vector2(minEnemySpawnTime, maxEnemySpawnTime))

func _on_heal_fruit_timer_timeout():
	spawn_item(healfruit_preload, healfruitTimer, "healfruit_collected", Callable(player, "_on_healfruit_collected"), Vector2(20 * timerMod, 30 * timerMod))

func _on_god_fruit_timer_timeout():
	spawn_item(godfruit_preload, godfruittimer, "godfruit_collected", Callable(player, "_on_godfruit_collected"), Vector2(30 * timerMod, 45 * timerMod))

func set_timers():
	godfruittimer.wait_time = randf_range(30 * timerMod, 45 * timerMod)
	godfruittimer.start() 
	healfruitTimer.wait_time = randf_range(20 * timerMod, 30 * timerMod)
	healfruitTimer.start()
	coinTimer.wait_time = randf_range(0.5 * timerMod, 1 * timerMod)
	coinTimer.start()
	fruitTimer.wait_time = 2.5
	fruitTimer.start()

func stop_spawn():
	coinTimer.stop()
	fruitTimer.stop()
	enemyTimer.stop()
	healfruitTimer.stop()
	godfruittimer.stop()

func resume_spawn(): 
	coinTimer.start()
	fruitTimer.start()
	enemyTimer.start()
	healfruitTimer.start()
	godfruittimer.start()

