extends State 

@onready var enemy_a = $"../.."
@onready var label = $"../../Label"

const POSITION_X = -260
var game_position = Vector2(POSITION_X, 84)

func Enter():
	# todo: change animation run
	label.text = "spawn"
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
