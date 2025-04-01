extends Node2D

@onready var pillar: Sprite2D = $pillar
@onready var enemy_c: Sprite2D = $enemy_c
@onready var timer_enemy_spawn: Timer = $Timer_EnemySpawn
@onready var timer_enemy_despawn: Timer = $Timer_EnemyDespawn

const ENEMY_SPAWN_POSITION = Vector2(200, 64)
const ENEMY_DESPAWN_POSITION = Vector2(500, 64)
const ENEMY_INTIAL_POSITION = Vector2(200, 300)

func _ready() -> void:
	enemy_c.position = ENEMY_INTIAL_POSITION
	timer_enemy_spawn.start()

func _process(delta: float) -> void:
	if Global.speed != 0:
		pillar.position.x -= Global.speed * delta
		if pillar.position.x < -1000:
			spawn_pillar()


func spawn_pillar():
	pillar.position.x = 1000

func spawn_enemy():
	var tween = create_tween()
	tween.tween_property(enemy_c, "position", ENEMY_SPAWN_POSITION, 1)
	tween.tween_callback(func (): timer_enemy_despawn.start())

func despawn_enemy():
	var tween = create_tween()
	tween.tween_property(enemy_c, "position", ENEMY_DESPAWN_POSITION, 2)
	tween.tween_callback(func (): 
		timer_enemy_spawn.start()
		enemy_c.position = ENEMY_INTIAL_POSITION)

func _on_timer_enemy_spawn_timeout() -> void:
	spawn_enemy()

func _on_timer_enemy_despawn_timeout() -> void:
	despawn_enemy()
