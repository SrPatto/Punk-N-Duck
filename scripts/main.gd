extends Node2D

var score
var gameRunning

const SPEED_MODIFIER = 50  

const MAX_SPEED = 700

func _ready() -> void:
	score = 0
	gameRunning = false
	Global.speed = 0
	$GameOver.hide()
	$HUD.get_node("StartLabel").show()
	$GameOver.get_node("Button").pressed.connect(new_game)
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
			$HUD.get_node("StartLabel").hide()
			gameRunning = true
			Global.speed = Global.START_SPEED
			Global.enemy_spawner.activateSpawner = true

func new_game():
	get_tree().paused = false
	get_tree().reload_current_scene()

func game_over():
	check_highscore()
	$GameOver.show()
	Global.enemy_spawner.activateSpawner = false
	Global.speed = 0
	gameRunning = false
	pass

func show_score():
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)

func check_highscore():
	if score > Global.high_score:
		Global.high_score = score
		$HUD.get_node("HighScoreLabel").text = "HIGH SCORE: " + str(Global.high_score)
