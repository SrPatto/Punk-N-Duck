extends AudioStreamPlayer

var music
var isPlayingGameplayMusic

func _ready():
	isPlayingGameplayMusic = false
	music = get_stream_playback()

func _process(delta):
	if get_parent().gameRunning:
		if !isPlayingGameplayMusic:
			music.switch_to_clip(1)
			isPlayingGameplayMusic = true
