extends Node

var player_name = ""
var player
var enemy_spawner 
var high_score = 0

const START_SPEED = 300
var speed

func _ready() -> void:
	SilentWolf.configure({
		"api_key": "rBI2EySFq24WJDe7IFyN36UwyIGGvW5x2bdGomSc",
		"game_id": "PUNK'NDUCK",
		"log_level": 0
	})
