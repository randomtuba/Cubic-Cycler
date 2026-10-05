// main vars
pos = new Position(x, y, 0.90, 0.99, self)

rotation = 0;
x_scale = 0.5;
collisions = []; update_collisions();

// lose state
lose_state = false
lose_timer = 0

// quality of life vars
coyote_time = 0
jump_buffer = 0
jump_cooldown = 0
springyspring = 0
springxspring = 0

// cool effects
jump_k = 0;
jump_j_max = sec;
bounciness = 1;

function restart() {
	if (global.checkpoint_id == -1) {
		room_goto(rm_start)
		global.level_x = 2
		global.level_y = 1
		pos.setPos(64, 480)
	} else {
		room_goto(global.checkpoint_room)
		global.level_x = global.checkpoint_level_x
		global.level_y = global.checkpoint_level_y
		pos.setPos(global.checkpoint_x, global.checkpoint_y)
	}
	pos.x_speed = 0
	pos.y_speed = 0
}

function update_collisions() {
	with (obj_global) {
		other.collisions = get_active_collisions()
	}
}

function room_index_bounded(_i = global.level_x, _j = global.level_y) {
	return (_j >= 0) && (_j < array_length(global.level_map)) &&
		(_i >= 0) && (_i < array_length(global.level_map[0])) &&
		global.level_map[_j][_i] != -1
}
	
