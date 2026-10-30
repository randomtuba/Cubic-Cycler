if (keyboard_check_pressed(ord("E"))) {
	global.pedestal_active = !global.pedestal_active
	global.pedestal = other
	//todo: check the shouldwrap is correct
}