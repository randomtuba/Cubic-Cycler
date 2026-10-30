if (keyboard_check_pressed(ord("E"))) {
	global.pedestal_active = !global.pedestal_active
	global.pedestal = other
	with (obj_pedestal) { image_index = 0; }
	other.image_index = global.pedestal_active
	//todo: check the shouldwrap is correct
}