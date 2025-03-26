extends Resource

class_name Spawn_info

@export var enemy: Resource
@export var canSpawn = true
@export var enemy_spawn_delay: int
@export_enum ("TOP_SPAWNPOINT", "MID_SPAWNPOINT", "BOT_SPAWNPOINT") var spawnPoint

var spawn_delay_counter = 0
