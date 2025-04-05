extends Node2D

@export var RANDOM_SHAKE_STRENGTH: float = 30.0
@export var SHAKE_DECAY_RATE: float = 5.0
@onready var dresser: AnimatedSprite2D = $Level/Spawn/Dresser
@onready var gameOver_UI: Control = $GameOver
@onready var camera_2d: Camera2D = $Camera2D
@onready var rand = RandomNumberGenerator.new()
var shake_strength: float = 0.0

var score: int
var gameRunning
var isGameOver

const SPEED_MODIFIER = 100  
const DECELERATION_RATE = 100
const MAX_SPEED = 700

func _ready() -> void:
	rand.randomize()
	score = 0
	gameRunning = false
	isGameOver = false
	Global.speed = 0
	gameOver_UI.get_node("CanvasLayer").hide()
	$MainMenu.show()
	#$HUD.get_node("StartLabel").show()
	gameOver_UI.get_node("CanvasLayer").get_node("HBoxContainer").get_node("RestartButton").pressed.connect(new_game)
	if Global.high_score != 0:
		$HUD.get_node("HighScoreLabel").text = "HIGH SCORE: " + str(Global.high_score)

func _process(delta: float) -> void:
	if gameRunning:
		if Global.speed < MAX_SPEED:
			Global.speed = Global.START_SPEED + score / SPEED_MODIFIER
		score += (Global.speed / 300)
		show_score()
	else:
		if Input.is_action_pressed("start_game"):
			if isGameOver:
				new_game()
			else:
				if dresser != null:
					$MainMenu.hide()
					dresser.play("default")
					Global.player.animated_sprite_2d.play("spawn")
	
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	camera_2d.offset = get_random_offset()

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

func deceleration():
	while Global.speed > 0:
			Global.speed = max(Global.speed - DECELERATION_RATE * get_process_delta_time(), 0)
			await get_tree().process_frame  # Wait for the next frame
	gameOver_UI.get_node("CanvasLayer").show()
	isGameOver = true

func show_score():
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)

func check_highscore():
	if score > Global.high_score:
		Global.high_score = score
		$HUD.get_node("HighScoreLabel").text = "HIGH SCORE: " + str(Global.high_score)
		SilentWolf.Scores.save_score(Global.player_name, Global.high_score)

func apply_shake(strength) -> void:
	shake_strength = strength

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)

func _on_dresser_animation_finished() -> void:
	start_game()
