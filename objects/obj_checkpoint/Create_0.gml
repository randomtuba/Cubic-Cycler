function apply_interaction(obj) {
	cooldown = 0;

	// cooldown for checkpoints
	if (cooldown > 0) { cooldown--; return; }

	// obj_checkpoint - apply_interaction
	function apply_interaction(obj) {
		if (cooldown > 0) return;   
		cooldown = 2 * room_speed;
		if (global.checkpoint_id != id) audio_play_sound(sfx_checkpoint, 0, false)
		global.checkpoint_id = id
		global.checkpoint_x = x
		global.checkpoint_y = y
		global.checkpoint_room = room
		global.checkpoint_level_x = global.level_x
		global.checkpoint_level_y = global.level_y

		checkpoint_write_file();
	}
}