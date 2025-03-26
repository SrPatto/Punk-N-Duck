extends State 

@onready var enemy_a = $"../.."
@onready var label = $"../../Label"

const POSITION_X = -400
var position_y = 0
var gameOff_position 

func Enter():
	# todo: change animation run
	label.text = "despawn"
	position_y = enemy_a.global_position.y
	gameOff_position = Vector2(POSITION_X, position_y)
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
	tween.tween_property(enemy_a, "position", gameOff_position, 1)
	tween.tween_callback(func (): 
		Global.enemy_spawner.spawns[enemy_a.spawnPosition].canSpawn = true
		enemy_a.queue_free())
