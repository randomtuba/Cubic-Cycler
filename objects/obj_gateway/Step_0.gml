image_angle += 10

if (get_destroyed_generator_count() >= 4 || global.debug) {
	visible = true
} else {
	visible = false
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
		
		// go to rm_start
		global.level_x = 2
		global.level_y = 1
		room_goto(rm_start)
		
		// unfreeze cubert
		with (obj_cubert) immobile = false
	}
}