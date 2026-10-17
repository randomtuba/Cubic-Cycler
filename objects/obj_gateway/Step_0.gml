image_angle += 10

if (global.act == 0) {
	if (get_destroyed_generator_count() >= 4 || global.debug) {
		visible = true
	} else {
		visible = false
	}
} else {
	if (obj_tesseract_drawer.collect_timer > sec * 5) {
		visible = true
	} else {
		visible = false
	}
}

if (active) {
	timer += 1
	if (timer < sec) {
		image_xscale += sin((timer / sec) * pi * 2) / 3
		image_yscale += sin((timer / sec) * pi * 2) / 3
	} else {
		actPlus()
	}
}
