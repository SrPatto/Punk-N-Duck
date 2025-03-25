extends CharacterBody2D

@onready var ray_cast_platform = $RayCast_Platform
@onready var ray_cast_death_sensor = $RayCast_DeathSensor

const RUN_SPEED = 300.0
const JUMP_VELOCITY = -500.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump up.
	if Input.is_action_just_pressed("jump_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()
	
func _process(delta):
	# Handle jump down.
	if ray_cast_platform.is_colliding():
		var collision = ray_cast_platform.get_collider()
		if collision.has_method("disable") and Input.is_action_just_pressed("jump_down"):
			collision.disable()
	# Handle death sensor
	if ray_cast_death_sensor.is_colliding():
		var collision = ray_cast_death_sensor.get_collider()
		if collision.is_in_group("obstacles"):
			death()

func death():
	get_tree().reload_current_scene()
