#region Follow Main Cubert (Side Cuberts Only)

if (!is_main_cubert) {
	if (instance_exists(main_cubert) && main_cubert != self) { 
		x = main_cubert.x + main_cubert_off_i[0]*room_width;
		y = main_cubert.y + main_cubert_off_i[1]*room_height;
		image_index = main_cubert.image_index;
		image_xscale = main_cubert.image_xscale;
		image_yscale = main_cubert.image_yscale;
		visible = false;//(instance_exists(obj_generator));
	}
	
	return;
}

#endregion Follow Main Cubert (Side Cuberts Only)

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

var groundCheck = checkGrounded(self, collisions)
var _grounded = !groundCheck.valid

run_events(getContacting(self, HAVE_CONTACT_BEHAVIOUR))
run_events(groundCheck.blockers)

#region Horizontal Movement

pos.x_speed += _lr * 0.75

/*
#region Tractor Beams

if (touching_up_tractor && !touching_down_tractor) {
	y_speed -= global.tractor_strength
} else if (touching_down_tractor && !touching_up_tractor) {
	y_speed += global.tractor_strength
}

if (touching_right_tractor && !touching_left_tractor) {
	x_speed += global.tractor_strength
} else if (touching_left_tractor && !touching_right_tractor) {
	x_speed -= global.tractor_strength
}

touching_up_tractor = false
touching_down_tractor = false
touching_right_tractor = false
touching_left_tractor = false

#endregion Tractor Beams
*/
#endregion Horizontal Movement

#region Coyote Time

/*var _grounded = place_meeting(x, y+2, collisions) 
	|| faux_place_meeting(0, 2, collisions)
var _grounded2 = place_meeting(x, y-2, collisions) || faux_place_meeting(0, -2, collisions);*/

if (_grounded) {
	coyote_time = global.coyote_time
} else if (coyote_time > 0) {
	coyote_time--
}

#endregion Coyote Time

#region Ground Collision and Diving

/*if (_grounded && springyspring == 0) {
	//y_speed = 0
} else if (_grounded && springyspring == 1) {
	springyspring = 0
} else if (_grounded2) {
	//y_speed = 1
} else {*/
	if (_down) { pos.y_speed += 0.8 } else { pos.y_speed += 0.4 }
//}

#endregion Ground Collision and Diving

#region Jumping

// Buffer
if (_jump) {
	jump_buffer = global.input_buffer_time
} else if (jump_buffer > 0) {
	jump_buffer--
}

// Jump
if (coyote_time > 0) {
	if (jump_buffer > 0) { 
		pos.y_speed = -10
		//jump_k = 1
		
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

//move_and_collide(x_speed, y_speed, collisions)

//move_and_collide_with_faux(x_this_frame, y_this_frame, collisions)
var motion = pos.getMotion()
var movement = attemptMove(self, collisions, motion.x, motion.y, 4, instance_exists(obj_generator))
if (!movement.x) {
	pos.x_speed = 0
}
if (!movement.y) {
	pos.y_speed = 0
}

#endregion Movement

#region Room Wrapping

update_current_room_data(room, x, y, pos.x_speed, pos.y_speed, global.level_x, global.level_y);

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

#endregion Room Wrapping

global.default_x = x
global.default_y = y

if (global.debug && mouse_check_button(mb_right)) { x = mouse_x; y = mouse_y; }

if (pos.x_speed != 0) {
	image_xscale = sign(pos.x_speed) * 0.5;
}
x_scale = lerp(x_scale, image_xscale, 0.9)


//var _crouch = !(keyboard_check(vk_down) || keyboard_check(ord("S"))) || place_meeting(x, y+2, collisions)
//image_index = !_crouch;