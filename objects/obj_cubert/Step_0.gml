if (player_copy == 0) {
	if (lose_state) {
		lose_timer -= delta_time / 1000000
		if (lose_timer <= 0) {
			lose_state = false
			x = 64
			y = 480
    }
  } else {
	x_speed += (keyboard_check(vk_right) - keyboard_check(vk_left)) * 0.75

<<<<<<< Updated upstream
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
=======
if (!is_main_cubert) {
	if (instance_exists(main_cubert) && main_cubert != self) { 
		x = main_cubert.x + main_cubert_offset[0];
		y = main_cubert.y + main_cubert_offset[1];
		image_index = main_cubert.image_index;
		image_xscale = main_cubert.image_xscale;
		image_yscale = main_cubert.image_yscale;
		if (instance_exists(obj_generator)) {
			visible = true
		} else {
			visible = false
		}
	}
>>>>>>> Stashed changes
	
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
	}
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

if (lose_state) {
	image_index = 2
} else {
	if (!keyboard_check(vk_down) || place_meeting(x, y+2, collision_map)) {
		image_index = 0
	} else {
		image_index = 1
	}
<<<<<<< Updated upstream
}
=======
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
		room_goto(asset_get_index(global.level_map[global.level_y][global.level_x]))
	}
} else if (x < 1) {
	x = room_width
	if (place_meeting(x, y, collision_map)) x = 0
	if (!instance_exists(obj_generator)) {
		global.level_x--
		room_goto(asset_get_index(global.level_map[global.level_y][global.level_x]))
	}
}

// Vertical
if (y > room_height) {
	y = 0
	if (place_meeting(x, y, collision_map)) y = room_height
	if (!instance_exists(obj_generator)) {
		global.level_y++
		room_goto(asset_get_index(global.level_map[global.level_y][global.level_x]))
	}
} else if (y < 1) {
	y = room_height
	if (place_meeting(x, y, collision_map)) y = 0
	if (!instance_exists(obj_generator)) {
		global.level_y--
		room_goto(asset_get_index(global.level_map[global.level_y][global.level_x]))
	}
}

#endregion Room Wrapping

global.default_x = x
global.default_y = y

if (x_speed != 0) { image_xscale = sign(x_speed) * 0.5 }

var _crouch = !(keyboard_check(vk_down) || keyboard_check(ord("S"))) || place_meeting(x, y+2, collision_map)
image_index = !_crouch;
>>>>>>> Stashed changes
