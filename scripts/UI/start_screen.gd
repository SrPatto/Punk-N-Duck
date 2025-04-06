extends Control

var player_name

func _on_submit_button_pressed() -> void:
	if $Panel/LineEdit.text != "":
		player_name = $Panel/LineEdit.text
		Global.player_name = player_name
		
		SceneTransition.change_scene("res://scenes/main.tscn")
		
	else:
		$Panel/noUsername_Label.show()
