extends Resource
class_name FloorData

# Properties
@export var time_interval: float
@export var background_textures: Array[Texture2D] = []
@export var enemy_scenes: Array[PackedScene] = []
@export var min_enemy_spawn_interval: float
@export var max_enemy_spawn_interval: float
