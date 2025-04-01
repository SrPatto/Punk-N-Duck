extends State 

class_name EnemyThrow_State

const PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")

@onready var enemy_a = $"../.."
@onready var shooting_point = $"../../ShootingPoint"
@onready var timer_reload = $"../../Timer_reload"
@onready var label = $"../../Label"
@onready var ray_cast_2d = $"../../RayCast2D"
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

var canThrow

func Enter():
	animated_sprite_2d.play("throw")
	label.text = "throw"
	canThrow = true
	pass
	
func Exit():
	pass
	
func Update(_delta: float):
	if ray_cast_2d.is_colliding():
		var collision = ray_cast_2d.get_collider()
		if collision.is_in_group("obstacles"):
			Transitioned.emit(self, "despawn") 
	if !Global.enemy_spawner.existPlatform(enemy_a.spawnPosition):
		Transitioned.emit(self, "despawn")
	if canThrow == false:
		Transitioned.emit(self, "chase")
		
	pass
	
func Physics_Update(_delta: float):
	pass
	
func throw():
	var projectile = PROJECTILE_SCENE.instantiate()
	projectile.global_position = shooting_point.global_position
	add_child(projectile)

func _on_animated_sprite_2d_animation_finished():
		throw()
		canThrow = false
		timer_reload.start()
