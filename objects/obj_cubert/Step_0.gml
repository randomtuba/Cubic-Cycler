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

sprite_index = keyboard_check(ord("1")) ? spr_cubert_1 : spr_cubert;
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

var _x_this_frame = 0
var _y_this_frame = 0

#region Horizontal Movement

x_speed += _lr * 0.75

x_speed *= x_drag
y_speed *= 0.99

#region Conveyors

if (touching_right_conveyor && !touching_left_conveyor) {
	_x_this_frame += global.conveyor_speed
} else if (touching_left_conveyor && !touching_right_conveyor) {
	_x_this_frame -= global.conveyor_speed
}

touching_right_conveyor = false
touching_left_conveyor = false

#endregion Conveyors

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

#endregion Horizontal Movement

#region Coyote Time

var _grounded = place_meeting(x, y+2, collisions) || faux_place_meeting(0, 2, collisions);
var _grounded2 = place_meeting(x, y-2, collisions) || faux_place_meeting(0, -2, collisions);

if (_grounded) {
	coyote_time = global.coyote_time
} else if (coyote_time > 0) {
	coyote_time--
}

#endregion Coyote Time

#region Ground Collision and Diving

if (_grounded and springyspring == 0) {
	y_speed = 0
} else if (_grounded and springyspring == 1) {
	springyspring = 0
} else if (_grounded2) {
	y_speed = 1
} else {
	if (_down) { y_speed += 0.8 } else { y_speed += 0.4 }
}

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
		y_speed = -10
		//jump_k = 1
		
		coyote_time = 0
		jump_buffer = 0
	}
}

#endregion Jumping

//move_and_collide(x_speed, y_speed, collisions)

_x_this_frame += x_speed
_y_this_frame += y_speed

move_and_collide_with_faux(_x_this_frame, _y_this_frame, collisions)

#endregion Movement
	
#region Room Wrapping


update_current_room_data(room, x, y, x_speed, y_speed, global.level_x, global.level_y);

// Horizontal
if (x > room_width) {
    x = 0
    if (place_meeting(x, y, collisions)) x = room_width
    if (!instance_exists(obj_generator)) {
        global.level_x++
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_x--; }
    }
} else if (x < 0) {
    x = room_width
    if (place_meeting(x, y, collisions)) x = 0
    if (!instance_exists(obj_generator)) {
        global.level_x--
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_x++; }
    }
}

// Vertical
if (y > room_height) {
    y = 0
    if (place_meeting(x, y, collisions)) y = room_height
    if (!instance_exists(obj_generator)) {
        global.level_y++
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_y--; }
    }
} else if (y < 0) {
    y = room_height
    if (place_meeting(x, y, collisions)) y = 0
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

if (x_speed != 0) { image_xscale = sign(x_speed) * 0.5; }
x_scale = lerp(x_scale, image_xscale, 0.9)


//var _crouch = !(keyboard_check(vk_down) || keyboard_check(ord("S"))) || place_meeting(x, y+2, collisions)
//image_index = !_crouch;