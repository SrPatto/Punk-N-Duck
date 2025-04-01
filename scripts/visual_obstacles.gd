extends Node2D

@onready var pillar: Sprite2D = $pillar

func _process(delta: float) -> void:
	if Global.speed != 0:
		pillar.position.x -= Global.speed * delta
		if pillar.position.x < -1000:
			spawn_pillar()

func spawn_pillar():
	pillar.position.x = 1000
