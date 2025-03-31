extends ParallaxBackground

func _process(delta):
	if Global.speed != 0:
		var scroll_speed = (Global.speed / 2)
		scroll_base_offset -= Vector2(scroll_speed, 0) * delta
