pos = new Position(x, y, 1, 1, self)

// Set initial speed
switch move_direction {
	case Direction.Up:
		pos.y_speed = -move_speed
	break

	case Direction.Down:
		pos.y_speed = move_speed
	break

	case Direction.Left:
		pos.x_speed = -move_speed
	break

	case Direction.Right:
		pos.x_speed = move_speed
	break
}

collisions = []; update_collisions()

function move_by_direction() {
	pos.move(pos.x_speed, pos.y_speed, instance_exists(obj_generator))
	
	for (var i = 0; i < array_length(connected_objects); i++) {
		current_object = connected_objects[i]
		current_object.x += pos.x_speed()
		current_object.y += pos.y_speed()
	}
}

function is_behind(_x, _y) {
	switch move_direction {
		case Direction.Up:
			return _y > pos.point.getY()
	
		case Direction.Down:
			return _y < pos.point.getY()
	
		case Direction.Left:
			return _x > pos.point.getX()
	
		case Direction.Right:
			return _x < pos.point.getX()
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
	pos.x_speed *= -1
	pos.y_speed *= -1
}

function match_speed(obj) {
	switch move_direction {
		case Direction.Up:
			if (obj.pos.y_speed > 0) {
				obj.pos.y_speed = 0
			}
		break
	
		case Direction.Down:
			if (obj.pos.y_speed < pos.y_speed) {
				obj.pos.y_speed = pos.y_speed
			}
		break
	
		case Direction.Left:
			if (obj.pos.x_speed > 0) {
				obj.pos.x_speed = 0
			}
		break
	
		case Direction.Right:
			if (obj.pos.x_speed < 0) {
				obj.pos.x_speed = 0
			}
		break
	}
}

function turn_if_colliding() {
	var contacts = getContacting(self, collisions)
	
	for (var i = 0; i < array_length(contacts); i++) {
		var obj = contacts[i]
		// Skip objects that are behind the platform
		if (is_behind(obj.pos.point.getX(), obj.pos.point.getY())) {
			continue
		}
		if (instance_exists(obj) && (array_contains(FREELY_MOVABLE_OBJECTS, obj.object_index))) {
			match_speed(obj)
			var success = attemptMove(obj, obj.collisions, pos.x_speed, pos.y_speed, 4, instance_exists(obj_generator))
			if ((success.x && pos.x_speed != 0) || (success.y && pos.y_speed != 0)) {
				continue
			}
		}
		turn_around()
		break
	}
}

function update_collisions() {
	with (obj_global) {
		other.collisions = get_active_collisions(true)
	}
}

function apply_interaction(obj) {
	if (move_direction == Direction.Down) {
		obj.pos.y_speed = pos.y_speed
	} else if (move_direction == Direction.Left || move_direction == Direction.Right) {
		obj.pos.x_this_frame += pos.x_speed
	}
}