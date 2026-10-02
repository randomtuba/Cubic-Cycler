enum Direction {
	Up,
	Down,
	Left,
	Right,
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
}