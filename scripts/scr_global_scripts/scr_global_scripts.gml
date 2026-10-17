function scr_global_scripts(){

}

function get_level_map() {
	var maps = [global.tutorial_map, global.act1_map, global.act2_map];
	return maps[clamp(global.act, 0, array_length(maps)-1)];
	//if (global.act == 0) {
	//	return global.tutorial_map;
	//} else {
	//	return global.act1_map;
	//}
}

function get_destroyed_generator_count() {
	var count = 0
	for (var i = 0; i < array_length(global.generators_destroyed_map); i++) {
		for (var j = 0; j < array_length(global.generators_destroyed_map[i]); j++) {
			if (global.generators_destroyed_map[i][j]) { count++ }
		}
	}
	return count
}