extends Area2D

class_name Projectile

@export var speed = 300

func _process(delta: float) -> void:
	position.x += delta * speed 

func _on_body_entered(body):
	queue_free()
