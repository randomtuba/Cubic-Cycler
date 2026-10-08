isOn = true

if (global.generators_destroyed_map[global.level_x][global.level_y]) {
	turn_off()
}

function turn_off() {
	if (isOn) {
		sprite_index = spr_generator_off
		isOn = false
	}
}

function apply_interaction(obj) {
	if (obj.object_index == obj_cubert) {
		global.generators_destroyed_map[global.level_x][global.level_y] = true;
		turn_off()
	}
}
