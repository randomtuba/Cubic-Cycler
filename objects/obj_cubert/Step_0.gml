if (player_copy == 0) {
	x_speed += (keyboard_check(vk_right) - keyboard_check(vk_left)) * 0.75

	x_speed *= x_drag
	y_speed *= 0.99

	if (place_meeting(x, y+2, collision_map)) {
		y_speed = 0
		if (keyboard_check(vk_up)) {
			y_speed = -10
		}
	} else if (place_meeting(x, y-2, collision_map)) {
		y_speed = 1
	} else {
		if (keyboard_check(vk_down)) {
			y_speed += 0.8
		} else {
			y_speed += 0.4
		}
	}

	move_and_collide(x_speed, y_speed, collision_map)
	
	if (x > 1024) {
		x = 0
		if (place_meeting(x, y, collision_map)) x = 1024
	} else if (x < 1) {
		x = 1024
		if (place_meeting(x, y, collision_map)) x = 0
	}
	
	if (y > 640) {
		y = 0
		if (place_meeting(x, y, collision_map)) y = 640
	} else if (y < 1) {
		y = 640
		if (place_meeting(x, y, collision_map)) y = 0
	}
	
	global.default_x = x
	global.default_y = y
} else {
	switch (player_copy) {
		case 1:
			x = global.default_x - 1024
			y = global.default_y
		break
		case 2:
			x = global.default_x + 1024
			y = global.default_y
		break
		case 3:
			x = global.default_x
			y = global.default_y - 640
		break
		case 4:
			x = global.default_x
			y = global.default_y + 640
		break
		case 5:
			x = global.default_x - 1024
			y = global.default_y - 640
		break
		case 6:
			x = global.default_x - 1024
			y = global.default_y + 640
		break
		case 7:
			x = global.default_x + 1024
			y = global.default_y - 640
		break
		case 8:
			x = global.default_x + 1024
			y = global.default_y + 640
		break
	}
}

with (obj_cubert) {
	if (x_speed != 0) image_xscale = sign(x_speed) * 0.5
}

if (!keyboard_check(vk_down) || place_meeting(x, y+2, collision_map)) {
	image_index = 0
} else {
	image_index = 1
}