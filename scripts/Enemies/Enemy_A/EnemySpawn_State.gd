extends State 

@onready var enemy_a = $"../.."
@onready var label = $"../../Label"

const POSITION_X = -260
var position_y = 0
var game_position 

func Enter():
	# todo: change animation run
	label.text = "spawn"
	position_y = enemy_a.global_position.y
	game_position = Vector2(POSITION_X, position_y)
	move_to_gamePosition()
	pass
	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
func move_to_gamePosition():
	var tween = create_tween()
	tween.tween_property(enemy_a, "position", game_position, 2)
	tween.tween_callback(func (): Transitioned.emit(self, "chase"))
