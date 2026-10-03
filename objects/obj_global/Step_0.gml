if (global.debug && keyboard_check_pressed(vk_f5)) { game_restart(); }

//on mac, i can't use f11 for some reaoson
if (keyboard_check_pressed(vk_f11) || (global.debug && keyboard_check_pressed(vk_f4))) {
	if (window_get_fullscreen()) {
		window_set_fullscreen(false);
		window_set_size(1024, 640)
		window_center()
	} else {
		window_set_fullscreen(true);
		window_set_size(display_get_width(), display_get_height())
		window_center()
	}
}

// Disable generators quickly (DEBUG TOOL)
if (global.debug && keyboard_check(vk_backspace)){
	global.generators_destroyed_map[global.level_x][global.level_y] = true;
	with (obj_generator) { instance_destroy() }
}
