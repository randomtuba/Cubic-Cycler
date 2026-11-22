wraps = true


// obj_checkpoint - apply_interaction
function apply_interaction(obj) {
		
	if (global.checkpoint_id != id) {
		audio_play_sound(sfx_checkpoint, 0, false, global.sfx_vol)
		global.checkpoint_id = id
		global.checkpoint_x = x
		global.checkpoint_y = y
		global.checkpoint_room = room
		global.checkpoint_level_x = global.level_x
		global.checkpoint_level_y = global.level_y
		global.checkpoint_level_gravity = image_angle - 90;
		
		checkpoint_write_file();
	}

}