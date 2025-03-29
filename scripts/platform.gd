extends StaticBody2D

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: Area2D = $Area2D

const shelves: CompressedTexture2D = preload("res://assets/sprites/platforms/Estanteria.png")
const boxes: CompressedTexture2D = preload("res://assets/sprites/platforms/Cajas.png")

@export_enum("shelve", "boxes") var sprite_platformType: String

func _ready():
	set_sprite(sprite_platformType)

func disable():
	area_2d.set_deferred("monitoring", true)

func _on_area_2d_body_entered(body: Node2D) -> void:
	collision_shape_2d.set_deferred("disabled", true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	collision_shape_2d.set_deferred("disabled", false)
	area_2d.set_deferred("monitoring", false)

func set_sprite(type):
	match type:
		"shelve":
			sprite_2d.texture = shelves
		"boxes":
			sprite_2d.texture = boxes
