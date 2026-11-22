if (keyboard_check_pressed(ord("E")) || gamepad_button_check_pressed(0, gp_face3)) {
	audio_play_sound(sfx_pedestal_click, 0, false, global.sfx_vol)
	global.pedestal_active = !global.pedestal_active
	global.pedestal = other
	with (obj_pedestal) { image_index = 0; }
	other.image_index = global.pedestal_active
	//todo: check the shouldwrap is correct
	
}