active = false
timer = 0

function apply_interaction(obj) {
	
	cooldown = 0;

// cooldown for checkpoints
	if (cooldown > 0) { cooldown--; return; }

// obj_checkpoint - apply_interaction
	function apply_interaction(obj) {
		if (cooldown > 0) return;   
		cooldown = 2 * room_speed;       

		global.checkpoint_id       = 1;
		global.checkpoint_x        = obj.pos.point.getX();
		global.checkpoint_y        = obj.pos.point.getY();
		global.checkpoint_room     = room;
		global.checkpoint_level_x  = global.level_x;
		global.checkpoint_level_y  = global.level_y;

		checkpoint_write_file();
	}

}