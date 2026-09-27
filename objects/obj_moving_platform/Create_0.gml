collisions = []; update_collisions()

function get_x_speed() {
	var mult = 0
	
	switch move_direction {
		case Direction.Left:
			mult = -1
		break
		
		case Direction.Right:
			mult = 1
		break
	}
	
	return move_speed * mult
}

function get_y_speed() {
	var mult = 0
	
	switch move_direction {
		case Direction.Up:
			mult = -1
		break
		
		case Direction.Down:
			mult = 1
		break
	}
	
	return move_speed * mult
}

function move_by_direction() {
	x += get_x_speed()
	y += get_y_speed()
	
	for (var i = 0; i < array_length(connected_objects); i++) {
		current_object = connected_objects[i]
		current_object.x += get_x_speed()
		current_object.y += get_y_speed()
	}
	
	try_room_wrap()
}

function try_room_wrap() {
	if (instance_exists(obj_generator)) {
		// Horizontal
		if (x > room_width) {
		    x = 0
		    if (place_meeting(x, y, collisions)) {
				x = room_width
				turn_around()
			}
		} else if (x < 0) {
		    x = room_width
		    if (place_meeting(x, y, collisions)) {
				x = 0
				turn_around()
			}
		}

		// Vertical
		if (y > room_height) {
		    y = 0
		    if (place_meeting(x, y, collisions)) {
				y = room_height
				turn_around()
			}
		} else if (y < 0) {
		    y = room_height
		    if (place_meeting(x, y, collisions)) {
				y = 0
				turn_around()
			}
		}
	}
}

function turn_around() {
	switch move_direction {
		case Direction.Up:
			move_direction = Direction.Down
		break
	
		case Direction.Down:
			move_direction = Direction.Up
		break
	
		case Direction.Left:
			move_direction = Direction.Right
		break
	
		case Direction.Right:
			move_direction = Direction.Left
		break
	}
}

function turn_if_colliding() {
	if (place_meeting(x, y, collisions)) {
		turn_around()
	}
}

function update_collisions() {
	with (obj_global) {
		other.collisions = get_active_collisions(true)
	}
}