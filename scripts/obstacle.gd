extends StaticBody2D

@onready var sprite_2d = $Sprite2D

const obstacle_A: CompressedTexture2D = preload("res://assets/sprites/obstacles/ObstaculoA.png")
const obstacle_B: CompressedTexture2D = preload("res://assets/sprites/obstacles/ObstaculoB.png")
const obstacle_C: CompressedTexture2D = preload("res://assets/sprites/obstacles/ObstaculoC.png")

@export_enum("obstacle_A", "obstacle_B", "obstacle_C") var sprite_ObstacleType: int

func _ready():
	set_sprite(sprite_ObstacleType)

func set_sprite(type):
	match type:
		0:
			sprite_2d.texture = obstacle_A
		1:
			sprite_2d.texture = obstacle_B
		2:
			sprite_2d.texture = obstacle_C
