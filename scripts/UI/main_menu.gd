extends CanvasLayer

@onready var high_score_label: Label = $HighScoreLabel
@onready var start_label: Label = $Menu_Container/StartLabel
@onready var play_button: Button = $Menu_Container/Buttons_Container/Play_Button
@onready var leaderboard_button: Button = $Menu_Container/Buttons_Container/Leaderboard_Button
@onready var return_button = $ReturnButton


func _on_return_button_pressed():
	SceneTransition.change_scene("res://scenes/UI/start_screen.tscn")
