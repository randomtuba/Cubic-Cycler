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