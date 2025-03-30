extends Node2D

@onready var level = $"../"

func _process(delta: float) -> void:
	position.x -= Global.level_speed * delta
	if position.x < -700:
		level.spawn_module(position.x + (level.amount * level.offset))
		queue_free()
