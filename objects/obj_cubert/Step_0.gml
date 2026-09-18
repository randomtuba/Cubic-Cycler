#region Follow Main Cubert (Side Cuberts Only)

if (!is_main_cubert) {
	if (instance_exists(main_cubert) && main_cubert != self) { 
		x = main_cubert.x + main_cubert_off_i[0]*room_width;
		y = main_cubert.y + main_cubert_off_i[1]*room_height;
		image_index = main_cubert.image_index;
		image_xscale = main_cubert.image_xscale;
		image_yscale = main_cubert.image_yscale;
		visible = (instance_exists(obj_generator));
	}
	
	return;
}

#endregion Follow Main Cubert (Side Cuberts Only)

#region Loss State

if (lose_state) {
	lose_timer -= 1
	if (lose_timer <= 0) {
		lose_state = false
		if (global.checkpoint_id == -1) {
			room_goto(rm_game)
			global.level_x = 1
			global.level_y = 1
			x = 64
			y = 480
		} else {
			room_goto(global.checkpoint_room)
			global.level_x = global.checkpoint_level_x
			global.level_y = global.checkpoint_level_y
			x = global.checkpoint_x
			y = global.checkpoint_y
		}
	}
	image_index = 2
	
	return;
}

#endregion Loss State

#region Movement

#region Horizontal Movement

var _lr = (keyboard_check(vk_right)||keyboard_check(ord("D"))) - (keyboard_check(vk_left)||keyboard_check(ord("A")))
x_speed += _lr * 0.75

x_speed *= x_drag
y_speed *= 0.99

#endregion Horizontal Movement

#region Coyote Time

var _grounded = place_meeting(x, y+2, collision_map) || faux_place_meeting(0, 2, collision_map);
var _grounded2 = place_meeting(x, y-2, collision_map) || faux_place_meeting(0, -2, collision_map);

if (_grounded) {
	coyote_time = global.coyote_time
} else if (coyote_time > 0) {
	coyote_time--
}

#endregion Coyote Time

#region Ground Collision and Diving

if (_grounded) {
	y_speed = 0
} else if (_grounded2) {
	y_speed = 1
} else {
	var _down = keyboard_check(vk_down) || keyboard_check(ord("S"))
	if (_down) { y_speed += 0.8 } else { y_speed += 0.4 }
}

#endregion Ground Collision and Diving

#region Jumping

// Buffer
var _jump = keyboard_check(vk_up) || keyboard_check(ord("W"))
if (_jump) {
	jump_buffer = global.input_buffer_time
} else if (jump_buffer > 0) {
	jump_buffer--
}

// Jump
if (coyote_time > 0) {
	if (jump_buffer > 0) { 
		y_speed = -10
		jump_k = 1
		
		coyote_time = 0
		jump_buffer = 0
	}
}

#endregion Jumping

//move_and_collide(x_speed, y_speed, collision_map)
move_and_collide_with_faux(x_speed, y_speed, collision_map)

#endregion Movement
	
#region Room Wrapping

// Horizontal
if (x > room_width) {
    x = 0
    if (place_meeting(x, y, collision_map)) x = room_width
    if (!instance_exists(obj_generator)) {
        global.level_x++
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_x--; x = xprevious; }
    }
} else if (x < 1) {
    x = room_width
    if (place_meeting(x, y, collision_map)) x = 0
    if (!instance_exists(obj_generator)) {
        global.level_x--
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_x++; x = xprevious; }
    }
}

// Vertical
if (y > room_height) {
    y = 0
    if (place_meeting(x, y, collision_map)) y = room_height
    if (!instance_exists(obj_generator)) {
        global.level_y++
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_y--; y = yprevious; }
    }
} else if (y < 1) {
    y = room_height
    if (place_meeting(x, y, collision_map)) y = 0
    if (!instance_exists(obj_generator)) {
        global.level_y--
		if (room_index_bounded(global.level_x, global.level_y)) {
			room_goto(global.level_map[global.level_y][global.level_x])
		} else { global.level_y++; y = yprevious;;}
    }
}

#endregion Room Wrapping

global.default_x = x
global.default_y = y

if (x_speed != 0) { image_xscale = sign(x_speed) * 0.5 }

var _crouch = !(keyboard_check(vk_down) || keyboard_check(ord("S"))) || place_meeting(x, y+2, collision_map)
image_index = !_crouch;