extends State

@onready var enemy_a = $"../.."
@onready var ray_cast_2d = $"../../RayCast2D"
@onready var timer_reload = $"../../Timer_reload"
@onready var label = $"../../Label"
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite_2d.play("run")
	label.text = "chase"
	pass
	
func Exit():
	pass
	
func Update(_delta: float):
	if ray_cast_2d.is_colliding():
		var collision = ray_cast_2d.get_collider()
		if collision == Global.player && timer_reload.is_stopped():
			Transitioned.emit(self, "throw")
		elif collision.is_in_group("obstacles"):
			Transitioned.emit(self, "despawn")
	if !Global.enemy_spawner.existPlatform(enemy_a.spawnPosition):
		Transitioned.emit(self, "despawn")
	pass
	
func Physics_Update(_delta: float):
	pass
