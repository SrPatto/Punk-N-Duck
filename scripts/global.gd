extends Node

var player_name = "test"
var player
var enemy_spawner 
var high_score = 0

const START_SPEED = 300
var speed

func _ready() -> void:
	SilentWolf.configure({
		"api_key": "rBI2EySFq24WJDe7IFyN36UwyIGGvW5x2bdGomSc",
		"game_id": "PUNK'NDUCK",
		"log_level": 1
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainPage.tscn"
	})
