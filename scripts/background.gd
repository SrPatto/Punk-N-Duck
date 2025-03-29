extends ParallaxBackground

var scroll_speed = 150

func _process(delta):
	scroll_base_offset -= Vector2(scroll_speed, 0) * delta
