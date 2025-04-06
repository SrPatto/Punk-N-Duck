extends CanvasLayer

@onready var score_label: Label = $Main_Container/Left_Container/GameInfo_Container/Score_Label
@onready var high_score_label: Label = $Main_Container/Left_Container/GameInfo_Container/HighScore_Label
@onready var restart_button: Button = $Main_Container/Left_Container/RestartButton
@onready var leaderboard: Control = $Main_Container/Panel/Leaderboard
