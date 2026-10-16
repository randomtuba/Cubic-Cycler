function actPlus(){
	if (true) {// go to next act
		
		// refresh map var and generators destroyed map
		_map = get_level_map();
		global.generators_destroyed_map = []
		for (var i=0; i<array_length(_map); i++) {
			array_push(global.generators_destroyed_map, []);
			for (var j=0; j<array_length(_map[0]); j++) {
				array_push(global.generators_destroyed_map[i], false);
			}
		}
		
		// set new checkpoint data and go to start room
		if (global.act == 1) {
			global.checkpoint_room = rm_start
			global.checkpoint_level_x = 2
			global.checkpoint_level_y = 1
			
			global.level_x = 2
			global.level_y = 1
			room_goto(rm_start)
		} else {
			global.checkpoint_room = rm2_camera_intro
			global.checkpoint_level_x = 0
			global.checkpoint_level_y = 0
			
			global.level_x = 0
			global.level_y = 0
			room_goto(rm2_camera_intro)
		}
		
		// unfreeze cubert
		with (obj_cubert) immobile = false
	}	
}