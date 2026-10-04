
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
	image_speed = 1
	with obj {
		switch (other.facing_direction) {
			case (Direction.Up):
				springyspring = 1
				pos.y_speed = -15
			break
			case (Direction.Down):
				pos.y_speed = 15
			break
			case (Direction.Right):
				springxspring = 1
				pos.x_speed = 15;

				// Reduce drag temporarily
				pos.x_drag = 0.95
				alarm[1] = sec/3
			break
			case (Direction.Left):
				springxspring = 1
				pos.x_speed = -15;

				// Reduce drag temporarily
				pos.x_drag = 0.95
				alarm[1] = sec/3
			break
			case (Direction.Yolo):
				var spring = _touched_spring_directions[Direction.Yolo];
				pos.x_speed = 15*dcos(spring.image_angle+90)
				pos.y_speed =-15*dsin(spring.image_angle+90)
			break
		}
	}
}
