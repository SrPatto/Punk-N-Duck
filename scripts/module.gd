extends Node2D

@onready var level = $"../"
var speed = 300

func _process(delta: float) -> void:
	position.x -= speed * delta
	if position.x < -700:
		level.spawn_module(position.x + (level.amount * level.offset))
		queue_free()
