extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
signal transitioned

func _ready() -> void:
	visible = false

func change_scene(target: String):
	visible = true
	animation_player.play("dissolve")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("dissolve")
	transitioned.emit()
	visible = false
