extends CharacterBody2D

@onready var ray_cast_platform = $RayCast_Platform
@onready var ray_cast_death_sensor = $RayCast_DeathSensor
@onready var timer_recover: Timer = $TimerRecover
@onready var animated_sprite_2d = $AnimatedSprite2D

const JUMP_VELOCITY = -700.0
var stumble_hits = 0
const INITIAL_POSITION = 0
const STUMBLE_POSITION_1 = -120
const STUMBLE_POSITION_2 = -220

func _ready():
	Global.player = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity()*2) * delta
		
	if not get_parent().gameRunning:
		#todo: idle animation
		pass
	else:
		# Handle jump up.
		if Input.is_action_just_pressed("jump_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	
	move_and_slide()
	
func _process(delta):
	# Handle jump down.
	if ray_cast_platform.is_colliding():
		var collision = ray_cast_platform.get_collider()
		if collision.has_method("disable") and Input.is_action_pressed("jump_down"):
			collision.disable()
	# Handle death sensor
	if ray_cast_death_sensor.is_colliding():
		var collision = ray_cast_death_sensor.get_collider()
		if collision.is_in_group("obstacles"):
			death()

func recover():
	if stumble_hits > 0:
		stumble_hits -= 1
		var tween = create_tween()
		match stumble_hits:
			0:
				tween.tween_property(self, "position:x", INITIAL_POSITION, 1)
			1:
				tween.tween_property(self, "position:x", STUMBLE_POSITION_1, 1)
				tween.tween_callback(func (): timer_recover.start())

func stumble():
	if stumble_hits < 2:
		stumble_hits += 1
		var tween = create_tween()
		match stumble_hits:
			1:
				tween.tween_property(self, "position:x", STUMBLE_POSITION_1, 1)
				tween.tween_callback(func (): timer_recover.start())
				
			2:
				tween.tween_property(self, "position:x", STUMBLE_POSITION_2, 1)
				tween.tween_callback(func (): timer_recover.start())

func death():
	get_tree().call_deferred("reload_current_scene")

func _on_timer_recover_timeout() -> void:
	recover()
