if (visible && !active) {
	audio_play_sound(sfx_teleport_quick, 0, false)
	with (obj_cubert) immobile = true
	active = true
}