// main vars
pos = new Position(x, y, 0.90, 0.99, self)

rotation = 0;
x_scale = 0.5;
collisions = []; update_collisions();
immobile = false

// lose state
lose_state = false
lose_timer = 0

// quality of life vars
coyote_time = 0
jump_buffer = 0
jump_cooldown = 0
springyspring = 0
springxspring = 0

// Landing "bouncy" vfx
jump_k = 0;
jump_j_max = sec;
bounciness = 10;
was_grounded = false

function restart() {
	if (global.checkpoint_id == -1) {
		if (global.act == 1) {
			room_goto(rm_start)
			global.level_x = 2
			global.level_y = 1
			pos.setPos(64, 480)
		} else {
			room_goto(rm_tut_top_left)
			global.level_x = 0
			global.level_y = 0
			pos.setPos(128, 480)
		}
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
	var _map = get_level_map();
	return true
	/* return (_j >= 0) && (_j < array_length(_map)) &&
		(_i >= 0) && (_i < array_length(_map[0])) &&
		_map[_j][_i] != -1 */
}
	
