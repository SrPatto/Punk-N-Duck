extends Control

@onready var hud: CanvasLayer = $HUD
@onready var main_menu: CanvasLayer = $MainMenu
@onready var game_over_menu: CanvasLayer = $GameOver_Menu
@onready var UIleaderboard: CanvasLayer = $Leaderboard

func show_MainMenu():
	main_menu.show()
	hud.hide()
	game_over_menu.hide()
	UIleaderboard.hide()

func show_GameOverMenu():
	game_over_menu.leaderboard.clear_leaderboard()
	game_over_menu.leaderboard.load_data()
	
	main_menu.hide()
	hud.hide()
	game_over_menu.show()
	UIleaderboard.hide()

func show_hud():
	main_menu.hide()
	hud.show()
	game_over_menu.hide()
	UIleaderboard.hide()

func show_leaderboard():
	UIleaderboard.leaderboard.clear_leaderboard()
	UIleaderboard.leaderboard.load_data()
	
	main_menu.hide()
	hud.hide()
	game_over_menu.hide()
	UIleaderboard.show()

func update_HighScore():
	main_menu.high_score_label.text = "HIGH SCORE: " + str(Global.high_score)
	hud.high_score_label.text = "HIGH SCORE: " + str(Global.high_score)
	game_over_menu.high_score_label.text = "HIGH SCORE: " + str(Global.high_score)
