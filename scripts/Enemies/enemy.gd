extends CharacterBody2D
class_name Enemy_Class

var spawnPosition

func _physics_process(_delta: float) -> void:
	move_and_slide()
