enum Direction {
	Up,
	Down,
	Left,
	Right,
	Yolo,
	None
}

// Sprite Rotation
switch (facing_direction) {
	case (Direction.Up):
		// Sprite already correct
	break
	case (Direction.Down):
		image_angle = 180
	break
	case (Direction.Right):
		image_angle = 270
	break
	case (Direction.Left):
		image_angle = 90
	break
	case (Direction.Yolo):
		//assume iamge_angle is given correctly
	break
}

function apply_interaction(obj) {
	with obj {
		switch (other.facing_direction) {
			case (Direction.Up):
				springyspring = 1
				self.y_speed = -15
			break
			case (Direction.Down):
				y_speed = 15
			break
			case (Direction.Right):
				springxspring = 1
				self.x_speed = -15;

				// Reduce drag temporarily
				x_drag = 0.95
				alarm[1] = sec/3
			break
			case (Direction.Left):
				springxspring = 1
				self.x_speed = 15;

				// Reduce drag temporarily
				x_drag = 0.95
				alarm[1] = sec/3
			break
			case (Direction.Yolo):
				var spring = _touched_spring_directions[Direction.Yolo];
				self.x_speed = 15*dcos(spring.image_angle+90)
				self.y_speed =-15*dsin(spring.image_angle+90)
			break
		}
	}
}
/*
	if (_touched_spring_directions[Direction.Up] != noone) {
		springyspring = 1
		self.y_speed = -15
	}
	if (_touched_spring_directions[Direction.Down] != noone) {
		y_speed = 15
	}
	if (_touched_spring_directions[Direction.Left] != noone) {
		springxspring = 1
		self.x_speed = -15;

		// Reduce drag temporarily
		x_drag = 0.95
		alarm[1] = sec/3
	}
	if (_touched_spring_directions[Direction.Right] != noone) {
		springxspring = 1
		self.x_speed = 15;

		// Reduce drag temporarily
		x_drag = 0.95
		alarm[1] = sec/3
	}
	if (_touched_spring_directions[Direction.Yolo] != noone) {
		var spring = _touched_spring_directions[Direction.Yolo];
		self.x_speed = 15*dcos(spring.image_angle+90)
		self.y_speed =-15*dsin(spring.image_angle+90)
	}
*/