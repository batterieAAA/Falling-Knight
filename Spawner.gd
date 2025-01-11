extends Area2D

@onready var coinTimer = $CoinTimer
@onready var fruitTimer = $FruitTimer
@onready var enemyTimer = $EnemyTimer
@onready var player = $"/root/Game/Knight"
@onready var healfruitTimer = $HealFruitTimer
@onready var godfruittimer = $GodFruitTimer

#Preload the item scene
var item_preload = preload("res://coin.tscn")
var fruit_preload = preload("res://fruit.tscn")
var healfruit_preload = preload("res://heal_fruit.tscn")
var godfruit_preload = preload("res://godfruit.tscn")
var enemies: Array[PackedScene] = []
var minEnemySpawnTime: float
var maxEnemySpawnTime: float
var speed : float = 100
var timerMod :float = speed/100




func _ready():
	$"../AnimationPlayer".play("main_menu_intro")
	await get_tree().create_timer(1).timeout
	SetTimers()




func initialize(floorData: FloorData, floor_above_five: float):
	minEnemySpawnTime = floorData.min_enemy_spawn_interval
	maxEnemySpawnTime = floorData.max_enemy_spawn_interval
	enemies = floorData.enemy_scenes

	speed = floorData.speed + (25 * floor_above_five)
	enemyTimer.wait_time = randf_range(minEnemySpawnTime, maxEnemySpawnTime)
	enemyTimer.start()

func _on_coin_timer_timeout():
	# Spawn a new item at a random position within the Area2D
	var item = item_preload.instantiate()

	var area_extents = $CollisionShape2D.shape.extents
	item.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	item.speed = speed

	# Connect the coin_collected signal to the player 
	item.connect("coin_collected", Callable(player, "_on_coin_collected"))
	coinTimer.wait_time = randf_range(0.5 * timerMod, 1 * timerMod)
	coinTimer.start()
	add_child(item)


func _on_fruit_timer_timeout():
	var fruit = fruit_preload.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	
	fruit.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	fruit.speed = speed
	fruit.connect("fruit_collected", Callable(player, "_on_fruit_collected"))
	add_child(fruit)
	fruitTimer.wait_time = 2.5
	fruitTimer.start()
	
func _on_enemy_timer_timeout():
	var enemy_scene = enemies[randi() % enemies.size()]
	var enemy = enemy_scene.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	enemy.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	enemy.speed = speed
	enemy.connect("enemy_touched", Callable(player, "_on_enemy_touched"))
	add_child(enemy)
	enemyTimer.wait_time = randf_range(minEnemySpawnTime, maxEnemySpawnTime)
	enemyTimer.start()


func _on_heal_fruit_timer_timeout():
	var healfruit = healfruit_preload.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	
	healfruit.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	healfruit.connect("healfruit_collected", Callable(player, "_on_healfruit_collected"))
	add_child(healfruit)
	healfruitTimer.wait_time = randf_range(20 * timerMod, 30 * timerMod)
	healfruitTimer.start()
	healfruit.speed = speed


func _on_god_fruit_timer_timeout():
	var godfruit = godfruit_preload.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	
	godfruit.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	godfruit.speed = speed
	godfruit.connect("godfruit_collected", Callable(player, "_on_godfruit_collected"))
	add_child(godfruit)
	godfruittimer.wait_time = randf_range(30 * timerMod, 45 * timerMod)


func SetTimers():
	godfruittimer.wait_time = randf_range(30 * timerMod, 45 * timerMod)
	godfruittimer.start() 
	
	healfruitTimer.wait_time = randf_range(20 * timerMod, 30 * timerMod)
	healfruitTimer.start()
	
	coinTimer.wait_time = randf_range(0.5 * timerMod, 1 * timerMod)
	coinTimer.start()
	
	fruitTimer.wait_time = 2.5
	fruitTimer.start()
	
func StopSpawn():
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
