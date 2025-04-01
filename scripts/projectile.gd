extends Area2D

class_name Projectile

@export var speed = 300

var direction

func _process(delta: float) -> void:
	if direction != 0:
		position.x += delta * speed * direction

func _on_body_entered(body):
	if body == Global.player:
		body.stumble()
	queue_free()
