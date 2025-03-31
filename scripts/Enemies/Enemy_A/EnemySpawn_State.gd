extends State 

@onready var enemy_a = $"../.."
@onready var label = $"../../Label"
@onready var ray_cast_2d = $"../../RayCast2D"
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

const POSITION_X = -260
var position_y = 0
var game_position 

func Enter():
	animated_sprite_2d.play("run")
	label.text = "spawn"
	position_y = enemy_a.global_position.y
	game_position = Vector2(POSITION_X, position_y)
	move_to_gamePosition()
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
	pass
	
func Physics_Update(_delta: float):
	pass
	
func move_to_gamePosition():
	var tween = create_tween()
	tween.tween_property(enemy_a, "position", game_position, 1)
	tween.tween_callback(func (): Transitioned.emit(self, "chase"))
