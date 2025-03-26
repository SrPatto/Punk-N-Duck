extends State 

class_name EnemyThrow_State

const PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")

@onready var enemy_a = $"../.."
@onready var shooting_point = $"../../ShootingPoint"
@onready var timer_reload = $"../../Timer_reload"
@onready var label = $"../../Label"
@onready var ray_cast_2d = $"../../RayCast2D"

var canThrow

func Enter():
	# todo: change animation throw
	label.text = "throw"
	canThrow = true
	throw()
	timer_reload.start()
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
	get_tree().root.add_child(projectile)
	canThrow = false
	
