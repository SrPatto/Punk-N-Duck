extends ParallaxBackground

var scroll_speed = (Global.level_speed / 2)

func _process(delta):
	scroll_base_offset -= Vector2(scroll_speed, 0) * delta
