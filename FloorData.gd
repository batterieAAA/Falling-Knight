extends Resource
class_name FloorData

# Properties
@export var floor_spawn_time: float
@export var background_color: Color
@export var enemy_scenes: Array[PackedScene] = []
@export var min_enemy_spawn_interval: float
@export var max_enemy_spawn_interval: float
@export var fruit_nb_required: float
