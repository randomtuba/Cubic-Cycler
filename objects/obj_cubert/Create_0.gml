// main vars
pos = new Position(x, y, 0.90, 0.99, self)

rotation = 0;
x_scale = 0.5;
//collision_map = layer_tilemap_get_id("Tiles_1")
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
	
/// @desc Handles interaction with a pushbox
/// @param {Id.Instance} box The pushbox
/// @param {Enum.Direction} dir The collision direction from cubert's perspective
function interact_with_pushbox(box, dir) {
	switch (dir) {
		case Direction.None:
		case Direction.Down:
			// Adjust speed
			var new_speed = (pos.y_speed + box.pos.y_speed) / 2 * 0.95
			pos.y_speed = new_speed
			box.pos.y_speed = new_speed
			
			// Snap self
			selfSize = getObjSize(self)
			boxSize = getObjSize(box)
			pos.setPos(
				pos.point.getX(),
				box.pos.point.getY() - boxSize.h / 2 - selfSize.h / 2 + 1
			)
		break
		
		case Direction.Up:
			// Adjust speed
			var new_speed = (pos.y_speed + box.pos.y_speed) / 2
			pos.y_speed = new_speed
			box.pos.y_speed = new_speed
			
			// Snap box
			selfSize = getObjSize(self)
			boxSize = getObjSize(box)
			box.pos.setPos(
				box.pos.point.getX(),
				pos.point.getY() - boxSize.h / 2 - selfSize.h / 2
			)
		break
		
		case Direction.Right:
			// Adjust speed
			var speed_change = pos.x_speed / 20
			pos.x_speed -= speed_change
			box.pos.x_speed += speed_change
			
			// Snap to box
			selfSize = getObjSize(self)
			boxSize = getObjSize(box)
			pos.setPos(
				box.pos.point.getX() - boxSize.w / 2 - selfSize.w / 2,
				pos.point.getY()
			)
		break
		
		case Direction.Left:
			// Adjust speed
			var speed_change = pos.x_speed / 20
			pos.x_speed -= speed_change
			box.pos.x_speed += speed_change
			
			// Snap to box
			selfSize = getObjSize(self)
			boxSize = getObjSize(box)
			pos.setPos(
				box.pos.point.getX() + boxSize.w / 2 + selfSize.w / 2,
				pos.point.getY()
			)
		break
	}
}

