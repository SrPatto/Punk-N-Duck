extends Area2D

enum Enemy_State {
	Spawn,
	Chase,
	Throw,
	Charge,
	Despawn
}
var current_state: Enemy_State = Enemy_State.Spawn

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var shooting_point: Marker2D = $ShootingPoint
@onready var timer_reload: Timer = $Timer_reload
@onready var label: Label = $Label

const PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")
const GAME_POSITION_X = -260
const GAME_OFF_POSITION_X = -400

var position_y = 0
var game_position 
var spawnPosition
var canThrow

func _ready() -> void:
	change_state(Enemy_State.Spawn)
	canThrow = true

func _process(delta: float):
	if ray_cast_2d.is_colliding():
		var collision = ray_cast_2d.get_collider()
		if collision.is_in_group("obstacles"):
			change_state(Enemy_State.Despawn)
		if collision == Global.player && timer_reload.is_stopped() && current_state == Enemy_State.Chase:
			change_state(Enemy_State.Throw)
	if !Global.enemy_spawner.existPlatform(spawnPosition):
		change_state(Enemy_State.Despawn)
	
	if canThrow == false && current_state == Enemy_State.Throw:
		change_state(Enemy_State.Chase)
	
	if !get_parent().activateSpawner:
		change_state(Enemy_State.Despawn)

func change_state(new_state: Enemy_State):
	current_state = new_state
	match current_state:
		Enemy_State.Spawn:
			animated_sprite_2d.play("run")
			label.text = "spawn"
			position_y = global_position.y
			game_position = Vector2(GAME_POSITION_X, position_y)
			move_to_gamePosition()
		
		Enemy_State.Chase:
			animated_sprite_2d.play("run")
			label.text = "chase"
		
		Enemy_State.Throw:
			animated_sprite_2d.play("throw")
			label.text = "throw"
			canThrow = true
			
		Enemy_State.Despawn:
			animated_sprite_2d.play("run")
			label.text = "despawn"
			position_y = global_position.y
			game_position = Vector2(GAME_OFF_POSITION_X, position_y)
			move_to_gamePosition()
		
		Enemy_State.Charge:
			animated_sprite_2d.play("charge")
			label.text = "charge"

func move_to_gamePosition():
	var tween = create_tween()
	tween.tween_property(self, "position", game_position, 1)
	tween.tween_callback(func ():
		if current_state == Enemy_State.Spawn:
			change_state(Enemy_State.Chase)
		elif current_state == Enemy_State.Despawn:
			Global.enemy_spawner.spawns[spawnPosition].canSpawn = true
			queue_free())

func throw():
	var projectile = PROJECTILE_SCENE.instantiate()
	projectile.global_position = shooting_point.global_position
	projectile.direction = 1
	get_parent().add_child(projectile)

func _on_body_entered(body: Node2D) -> void:
	if body == Global.player:
		change_state(Enemy_State.Charge)
		body.call_deferred("death")

func _on_animated_sprite_2d_animation_finished() -> void:
	if current_state == Enemy_State.Throw:
		throw()
		canThrow = false
		timer_reload.start()
	if current_state == Enemy_State.Charge:
		change_state(Enemy_State.Despawn)
