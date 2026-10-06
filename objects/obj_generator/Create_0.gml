if (global.generators_destroyed_map[global.level_x][global.level_y]) { instance_destroy() }

function apply_interaction(obj) {
	if (obj.object_index == obj_cubert) {
		global.generators_destroyed_map[global.level_x][global.level_y] = true;
		instance_destroy()
	}
}