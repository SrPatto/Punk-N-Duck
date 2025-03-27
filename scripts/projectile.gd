extends Area2D

class_name Projectile

@export var speed = 300

func _process(delta: float) -> void:
	position.x += delta * speed 

func _on_body_entered(body):
	if body == Global.player:
		body.stumble()
	queue_free()
