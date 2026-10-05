function scr_global_scripts(){

}

function get_level_map() {
	return global.tutorial_map;
}

function get_destroyed_generator_count() {
	var count = 0
	for (var i = 0; i < array_length(global.generators_destroyed_map); i++) {
		for (var j = 0; j < array_length(global.generators_destroyed_map[i]); j++) {
			if (global.generators_destroyed_map[i][j]) {
				count++
			}
		}
	}
	return count
}