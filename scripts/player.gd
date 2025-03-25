extends CharacterBody2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D

const RUN_SPEED = 300.0
const JUMP_VELOCITY = -500.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if ray_cast_2d.is_colliding():
		var collision = ray_cast_2d.get_collider()
		if collision.has_method("disable") and Input.is_action_just_pressed("jump_down"):
			collision.disable()
	
	move_and_slide()
