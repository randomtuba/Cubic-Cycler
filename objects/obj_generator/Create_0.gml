isOn = true

if (global.generators_destroyed_map[global.level_x][global.level_y]) {
	turn_off()
}

function turn_off(actually_turn_on = false) {
	if (isOn) {
		//turn it off
		sprite_index = spr_generator_off
		isOn = false
	}
	if (actually_turn_on && !isOn) {
		//turn it on
		sprite_index = spr_generator
		isOn = true
	}
}

function apply_interaction(obj) {
	if (obj.object_index == obj_cubert) {
		if (!global.generators_destroyed_map[global.level_x][global.level_y]) audio_play_sound(sfx_generator_break, 0, false)
		global.generators_destroyed_map[global.level_x][global.level_y] = true;
		turn_off()
	}
}
