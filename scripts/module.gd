extends Node2D

@onready var level = $"../"

func _process(delta: float) -> void:
	if Global.speed != 0:
		position.x -= Global.speed * delta
		if position.x < -600:
			level.spawn_module(position.x + (level.amount * level.offset))
			queue_free()
