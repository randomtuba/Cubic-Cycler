image_speed = 0
depth = 10094

function run_button_menu(_x = x) {
	if (_x > 690) {
		room_goto(rm_controls)
	} else {
		with (obj_music_handler) { audio_stop_sound(song) }
		global.act = 0;
		global.actsaved = 0;
		global.checkpoint_id = -1;
		global.checkpoint_level_gravity = 270;
		with (obj_cubert) { gravity_direction = 270; }
		room_goto(rm_tut_top_left)
		checkpoint_reset_progress()
	}
}