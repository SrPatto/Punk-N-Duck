extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var box_destroy_sfx: AudioStreamPlayer = $BoxDestroy_SFX

@export_enum("A", "B", "C") var sprite_ObstacleType: String

func _ready():
	set_sprite(sprite_ObstacleType)

func set_sprite(type):
	match type:
		"A":
			animated_sprite_2d.play("box_A")
		"B":
			animated_sprite_2d.play("box_B")
		"C":
			animated_sprite_2d.play("box_C")

func destroy():
	box_destroy_sfx.play()
	collision_shape_2d.disabled = true
	match sprite_ObstacleType:
		"A":
			animated_sprite_2d.play("destroy_A")
		"B":
			animated_sprite_2d.play("destroy_B")
		"C":
			animated_sprite_2d.play("destroy_C")
