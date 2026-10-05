
#region Loss State

image_index = 2*lose_state
if (lose_state) {
	lose_timer -= 1
	if (lose_timer <= 0) {
		lose_state = false
		restart()
	}
	
	return;
}

if (keyboard_check(ord("R"))) restart()

#endregion Loss State

#region Controls

var _lr = (keyboard_check(vk_right)||keyboard_check(ord("D"))) - (keyboard_check(vk_left)||keyboard_check(ord("A")))
var _down = keyboard_check(vk_down) || keyboard_check(ord("S"))
var _jump = keyboard_check(vk_up) || keyboard_check(ord("W")) || keyboard_check(vk_space)

#endregion

#region Movement

var groundCheck = checkGrounded(self, collisions, 5)
var _grounded = !groundCheck.valid

runEventsAndGrounded(groundCheck.blockers)

#region Horizontal Movement

pos.x_speed += _lr * 0.75

#endregion Horizontal Movement

#region Coyote Time

if (_grounded) {
	coyote_time = global.coyote_time
} else if (coyote_time > 0) {
	coyote_time--
}

#endregion Coyote Time

#region Gravity

if (_down) { pos.y_speed += 0.8 } else { pos.y_speed += 0.4 }

#endregion Gravity

#region Jumping

// Buffer
if (_jump) {
	jump_buffer = global.input_buffer_time
} else if (jump_buffer > 0) {
	jump_buffer--
}

// Cooldown
if (jump_cooldown > 0) {
	jump_cooldown--
}

// Jump
if (coyote_time > 0) {
	if (jump_buffer > 0 && jump_cooldown == 0) { 
		pos.y_speed = -10
		
		jump_cooldown = 10
		coyote_time = 0
		jump_buffer = 0
		
		//Apply speed from conveyors
		if (pos.hit_right_conveyor && !pos.hit_left_conveyor) {
			pos.x_speed += global.conveyor_speed
			// Reduce drag temporarily
			pos.x_drag = 0.95
			alarm[1] = sec/3
		} else if (pos.hit_left_conveyor && !pos.hit_right_conveyor) {
			pos.x_speed -= global.conveyor_speed
			// Reduce drag temporarily
			pos.x_drag = 0.95
			alarm[1] = sec/3
		}
	}
}

#endregion Jumping

var motion = pos.getMotion()
var movement = attemptMove(self, collisions, motion.x, motion.y, 4, instance_exists(obj_generator))

// Pushbox interactions
// "d" is a direction
for (var d = 0; d < 5; d++) {
	var set = movement.blockers[d]
	
	for (var i = 0; i < array_length(set); i++) {
		var obj = set[i]
		if (instance_exists(obj) && obj.object_index == obj_pushbox) {
			interact_with_pushbox(obj, d)
			// Don't reset speed when pushing a box
			if (d == Direction.Left || d == Direction.Right) {
				movement.x = true
			} else if (d == Direction.Up || d == Direction.Down) {
				movement.y = true
			}
		}
	}
}

// Reset speed if blocked
if (!movement.x) {
	pos.x_speed = 0
}
if (!movement.y) {
	pos.y_speed = 0
}

#endregion Movement

#region Room Changing

// Horizontal
if (x > room_width) {
    if (!instance_exists(obj_generator)) {
        global.level_x++
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_x--; }
    }
} else if (x < 0) {
    if (!instance_exists(obj_generator)) {
        global.level_x--
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_x++; }
    }
}

// Vertical
if (y > room_height) {
    if (!instance_exists(obj_generator)) {
        global.level_y++
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_y--; }
    }
} else if (y < 0) {
    if (!instance_exists(obj_generator)) {
        global.level_y--
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_y++; }
    }
}

#endregion Room Changing

global.default_x = x
global.default_y = y

if (global.debug && mouse_check_button(mb_right)) { x = mouse_x; y = mouse_y; }

if (pos.x_speed != 0) {
	image_xscale = sign(pos.x_speed) * 0.5;
}
x_scale = lerp(x_scale, image_xscale, 0.9)
