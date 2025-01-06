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

func _ready():
	SetTimers()

func initialize(floorData: FloorData):
	minEnemySpawnTime = floorData.min_enemy_spawn_interval
	maxEnemySpawnTime = floorData.max_enemy_spawn_interval
	enemies = floorData.enemy_scenes
	
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

	# Connect the coin_collected signal to the player 
	item.connect("coin_collected", Callable(player, "_on_coin_collected"))
	coinTimer.wait_time = randf_range(1, 2)
	coinTimer.start()
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
	fruitTimer.start()
	
func _on_enemy_timer_timeout():
	var enemy_scene = enemies[randi() % enemies.size()]
	var enemy = enemy_scene.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	enemy.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
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
	healfruitTimer.wait_time = randf_range(45, 60)
	healfruitTimer.start()


func _on_god_fruit_timer_timeout():
	var godfruit = godfruit_preload.instantiate()
	var area_extents = $CollisionShape2D.shape.extents
	
	godfruit.position = Vector2(
		randf_range(-area_extents.x, area_extents.x),
		randf_range(-area_extents.y, area_extents.y)
	)
	godfruit.connect("godfruit_collected", Callable(player, "_on_godfruit_collected"))
	add_child(godfruit)
	godfruittimer .wait_time = randf_range(60, 120)


func SetTimers():
	godfruittimer.wait_time = randf_range(60, 120)
	godfruittimer.start() 
	
	healfruitTimer.wait_time = randf_range(45, 60)
	healfruitTimer.start()
	
	coinTimer.wait_time = randf_range(1, 2)
	coinTimer.start()
	
	fruitTimer.wait_time = randf_range(1.5, 2.5)
	fruitTimer.start()
	
