switch type {
	case MovingPlatformType.Stationary:
		// Doesn't do anything
	break
		
	case MovingPlatformType.Bounce:
		move_by_direction()
		turn_if_colliding()
	break
}