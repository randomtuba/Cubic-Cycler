image_speed = 0

function run_button_menu(_x = x) {
	if (_x > 690) {
		room_goto(rm_controls)
	} else {
		with (obj_music_handler) {
			audio_stop_sound(song)
		}
		room_goto(rm_tut_top_left)
	}
}