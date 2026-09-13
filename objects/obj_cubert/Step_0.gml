//follow in main_cubert's footsteps
if (!is_main_cubert) {
	if (instance_exists(main_cubert) && main_cubert != self) { 
		x = main_cubert.x + main_cubert_offset[0];
		y = main_cubert.y + main_cubert_offset[1];
		image_index = main_cubert.image_index;
		image_xscale = main_cubert.image_xscale;
		image_yscale = main_cubert.image_yscale;
	}
	
	return;
}

if (lose_state) {
	lose_timer -= 1
	if (lose_timer <= 0) {
		lose_state = false
		x = 64
		y = 480
	}
	image_index = 2
	
	return;
}

//movement & collision & control
var _lr = (keyboard_check(vk_right)||keyboard_check(ord("D"))) - (keyboard_check(vk_left)||keyboard_check(ord("A")))
x_speed += _lr * 0.75

x_speed *= x_drag
y_speed *= 0.99

var _grounded = place_meeting(x, y+2, collision_map) || faux_place_meeting(0, 2, collision_map);
var _grounded2 = place_meeting(x, y-2, collision_map) || faux_place_meeting(0, -2, collision_map);

if (_grounded) {
	y_speed = 0
	var _jump = keyboard_check(vk_up) || keyboard_check(ord("W"))
	if (_jump) { y_speed = -10; jump_k = 1; }
} else if (_grounded2) {
	y_speed = 1
} else {
	var _down = keyboard_check(vk_down) || keyboard_check(ord("S"))
	if (_down) { y_speed += 0.8 } else { y_speed += 0.4 }
}

//move_and_collide(x_speed, y_speed, collision_map)
move_and_collide_with_faux(x_speed, y_speed, collision_map)
	
if (x > room_width) {
	x = 0
	if (place_meeting(x, y, collision_map)) x = room_width
} else if (x < 1) {
	x = room_width
	if (place_meeting(x, y, collision_map)) x = 0
}

if (y > room_height) {
	y = 0
	if (place_meeting(x, y, collision_map)) y = room_height
} else if (y < 1) {
	y = room_height
	if (place_meeting(x, y, collision_map)) y = 0
}

global.default_x = x
global.default_y = y

if (x_speed != 0) { image_xscale = sign(x_speed) * 0.5 }

var _crouch = (!keyboard_check(vk_down) || place_meeting(x, y+2, collision_map))
image_index = !_crouch;
