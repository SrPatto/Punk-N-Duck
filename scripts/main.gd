extends Node2D

@export var RANDOM_SHAKE_STRENGTH: float = 30.0
@export var SHAKE_DECAY_RATE: float = 5.0
@onready var dresser: AnimatedSprite2D = $Level/Spawn/Dresser
@onready var ui_control: Control = $UI_Control
@onready var camera_2d: Camera2D = $Camera2D
@onready var rand = RandomNumberGenerator.new()
var shake_strength: float = 0.0

var score: int
var gameRunning
var isGameOver
var gameOverFlag = 0 

const SPEED_MODIFIER = 75  
const DECELERATION_RATE = 100
const MAX_SPEED = 700

func _ready() -> void:
	rand.randomize()
	score = 0
	gameRunning = false
	isGameOver = false
	Global.speed = 0
	ui_control.show_MainMenu()
	handle_Buttons()
	if Global.high_score != 0:
		ui_control.update_HighScore()

func _process(delta: float) -> void:
	if gameRunning:
		increase_speed()
		score += (Global.speed / 300)
		show_score()
	else:
		if Input.is_action_pressed("start_game"):
			if isGameOver:
				new_game()
			else:
				play_start_animation()
	if isGameOver && gameOverFlag == 0:
		ui_control.show_GameOverMenu()
		gameOverFlag = 1
	
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	camera_2d.offset = get_random_offset()

func play_start_animation():
	if dresser != null:
		ui_control.show_hud()
		dresser.play("default")
		Global.player.animated_sprite_2d.play("spawn")

func start_game():
	$Visual_Obstacles.timer_enemy_spawn.start()
	gameRunning = true
	Global.speed = Global.START_SPEED
	Global.enemy_spawner.activateSpawner = true

func new_game():
	get_tree().reload_current_scene()

func game_over():
	check_highscore()
	Global.enemy_spawner.activateSpawner = false
	gameRunning = false
	deceleration()

func increase_speed():
	if Global.speed < MAX_SPEED:
		Global.speed = Global.START_SPEED + score / SPEED_MODIFIER

func deceleration():
	while Global.speed > 0:
			Global.speed = max(Global.speed - DECELERATION_RATE * get_process_delta_time(), 0)
			await get_tree().process_frame  # Wait for the next frame
	ui_control.game_over_menu.score_label.text = "SCORE: " + str(score)
	isGameOver = true

func show_score():
	ui_control.hud.score_label.text = "SCORE: " + str(score)

func check_highscore():
	if score > Global.high_score:
		Global.high_score = score
		ui_control.update_HighScore()
		SilentWolf.Scores.save_score(Global.player_name, Global.high_score)

func apply_shake(strength) -> void:
	shake_strength = strength

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)

func handle_Buttons():
	# Main menu
	ui_control.main_menu.play_button.pressed.connect(play_start_animation)
	ui_control.main_menu.leaderboard_button.pressed.connect(ui_control.show_leaderboard)
	
	# GameOver Menu
	ui_control.game_over_menu.restart_button.pressed.connect(new_game)
	
	# Leaderboard
	ui_control.UIleaderboard.return_button.pressed.connect(ui_control.show_MainMenu)

func _on_dresser_animation_finished() -> void:
	start_game()
