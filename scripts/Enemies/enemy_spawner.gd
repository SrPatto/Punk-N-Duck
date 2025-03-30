extends Node2D

@export var spawns: Array[Spawn_info] = []
@export var spawn_points: Array[Marker2D] = []
@onready var top_sensor = $PlatformSensors/Top_sensor
@onready var mid_sensor = $PlatformSensors/Mid_sensor

var time = 0
var existPlatform_0
var existPlatform_1

var activateSpawner: bool

func _ready():
	Global.enemy_spawner = self
	activateSpawner = false
	reset_spawners()

func _process(delta):
	platform_sensor()

func _on_timer_timeout() -> void:
	var enemy_spawns = spawns
	var enemySpawn_info = enemy_spawns.pick_random()
	if activateSpawner:
		if enemySpawn_info.canSpawn && existPlatform(enemySpawn_info.spawnPoint):
			if enemySpawn_info.spawn_delay_counter < enemySpawn_info.enemy_spawn_delay:
				enemySpawn_info.spawn_delay_counter += 1
			else:
				enemySpawn_info.spawn_delay_counter = 0
				var new_enemy = load(str(enemySpawn_info.enemy.resource_path))
				var spawn_point = get_spawnPoint(enemySpawn_info)
				var enemy_spawn = new_enemy.instantiate()
				enemy_spawn.global_position = spawn_point.global_position
				enemy_spawn.spawnPosition = enemySpawn_info.spawnPoint
				add_child(enemy_spawn)
				enemySpawn_info.canSpawn = false

func existPlatform(spawn_platform):
	match spawn_platform:
		0:
			return existPlatform_0
		1:
			return existPlatform_1
		2:
			return true

func platform_sensor():
	if top_sensor.is_colliding():
		var collider = top_sensor.get_collider()
		if collider.get_collision_layer() == 512:
			existPlatform_0 = true
		elif collider.get_collision_layer() == 256:
			existPlatform_0 = false
	
	if mid_sensor.is_colliding():
		var collider = mid_sensor.get_collider()
		if collider.get_collision_layer() == 512:
			existPlatform_1 = true
		elif collider.get_collision_layer() == 256:
			existPlatform_1 = false

func get_spawnPoint(enemySpawn_info):
	return spawn_points[enemySpawn_info.spawnPoint]

func reset_spawners():
	for i in spawns:
		i.canSpawn = true
