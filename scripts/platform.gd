extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: Area2D = $Area2D

func disable():
	area_2d.set_deferred("monitoring", true)

func _on_area_2d_body_entered(body: Node2D) -> void:
	collision_shape_2d.set_deferred("disabled", true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	collision_shape_2d.set_deferred("disabled", false)
	area_2d.set_deferred("monitoring", false)
