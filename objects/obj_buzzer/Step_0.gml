if (!array_contains(global.tesseracts[1], false) && image_index != 1) {
	image_index = 1
	with (obj_music_handler) game_done = true
	audio_stop_all()
}