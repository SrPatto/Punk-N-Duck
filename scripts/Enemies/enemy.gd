extends Area2D
class_name Enemy_Class

var spawnPosition

func _on_body_entered(body: Node2D) -> void:
	if body == Global.player:
		body.call_deferred("death")
