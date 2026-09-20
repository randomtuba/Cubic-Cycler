if (keyboard_check_pressed(vk_f5)) { game_restart(); }

if (keyboard_check_pressed(vk_f11)) {
	if (fullscreen) {
		window_set_size(1024, 640)
		window_center()
	} else {
		window_set_size(display_get_width(), display_get_height())
		window_center()
	}
	fullscreen = !fullscreen
}