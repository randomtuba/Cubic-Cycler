if (player_copy == 0) {
	var _lr = (keyboard_check(vk_right) - keyboard_check(vk_left))
	x_speed += _lr * 0.75

	x_speed *= 0.9
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
	
	with (obj_cubert) {
	if (x_speed != 0) { image_xscale = sign(x_speed) * 0.5 }
}

} else {
	switch (player_copy) {
		case 1:
			x = global.default_x - room_width
			y = global.default_y
		break
		case 2:
			x = global.default_x + room_width
			y = global.default_y
		break
		case 3:
			x = global.default_x
			y = global.default_y - room_height
		break
		case 4:
			x = global.default_x
			y = global.default_y + room_height
		break
		case 5:
			x = global.default_x - room_width
			y = global.default_y - room_height
		break
		case 6:
			x = global.default_x - room_width
			y = global.default_y + room_height
		break
		case 7:
			x = global.default_x + room_width
			y = global.default_y - room_height
		break
		case 8:
			x = global.default_x + room_width
			y = global.default_y + room_height
		break
	}
}

if (!keyboard_check(vk_down) || place_meeting(x, y+2, collision_map)) {
	image_index = 0
} else {
	image_index = 1
}