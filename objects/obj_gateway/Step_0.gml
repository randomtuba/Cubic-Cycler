image_angle += 10

if (global.act == 0) {
	if (get_destroyed_generator_count() >= 4 || global.debug) {
		visible = true
	} else {
		visible = false
	}
} else {
	if (obj_tesseract_drawer.collect_timer > sec * 5) {
		visible = true
	} else {
		visible = false
	}
}

if (active) {
	timer += 1
	if (timer < sec) {
		image_xscale += sin((timer / sec) * pi * 2) / 3
		image_yscale += sin((timer / sec) * pi * 2) / 3
	} else {
		// go to next act
		global.act++
		
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