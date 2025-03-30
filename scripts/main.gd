extends Node2D

var score

func _ready() -> void:
	score = 0

func _process(delta: float) -> void:
	score += (Global.level_speed / 300)
	show_score()

func show_score():
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)
