extends State

@onready var ray_cast_2d = $"../../RayCast2D"
@onready var timer_reload = $"../../Timer_reload"
@onready var label = $"../../Label"


func Enter():
	# todo: change animation
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
	pass
	
func Physics_Update(_delta: float):
	pass
