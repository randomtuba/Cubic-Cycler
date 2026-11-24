function apply_interaction(obj) {
	with obj {
		if (obj.object_index == obj_cubert && !lose_state) {
			audio_play_sound(sfx_lose, 0, false, global.sfx_vol)
			lose_state = true
			lose_timer = 0.25*sec
		}
	}
}