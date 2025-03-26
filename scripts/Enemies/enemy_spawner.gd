extends Node2D

@export var spawns: Array[Spawn_info] = []
@export var spawn_points: Array[Marker2D] = []

var time = 0
var canSpawn = true

func _ready():
	Global.enemy_spawner = self
	reset_spawners()

func _on_timer_timeout() -> void:
	var enemy_spawns = spawns
	var enemySpawn_info = enemy_spawns.pick_random()
	
	if enemySpawn_info.canSpawn:
		if enemySpawn_info.spawn_delay_counter < enemySpawn_info.enemy_spawn_delay:
			enemySpawn_info.spawn_delay_counter += 1
		else:
			enemySpawn_info.spawn_delay_counter = 0
			var spawn_point = get_spawnPoint(enemySpawn_info)
			var new_enemy = load(str(enemySpawn_info.enemy.resource_path))
			var enemy_spawn = new_enemy.instantiate()
			enemy_spawn.global_position = spawn_point.global_position
			enemy_spawn.spawnPosition = enemySpawn_info.spawnPoint
			add_child(enemy_spawn)
			enemySpawn_info.canSpawn = false

func get_spawnPoint(enemySpawn_info):
	return spawn_points.get(enemySpawn_info.spawnPoint)

func reset_spawners():
	for i in spawns:
		i.canSpawn = true
