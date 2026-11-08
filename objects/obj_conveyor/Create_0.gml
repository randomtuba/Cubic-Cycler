#region Set correct sprite

// Select correct sprite
switch visual_type {
	case ConveyorVisualType.Center: {
		sprite_index = spr_conveyor_center
	} break
	
	case ConveyorVisualType.Center_Covered: {
		sprite_index = spr_conveyor_center_covered
	} break
	
	case ConveyorVisualType.End_Left: {
		// Change which end based on conveyor direction, since sprite gets flipped later
		if (direction == Direction.Right) {
			sprite_index = spr_conveyor_end_left
		} else {
			sprite_index = spr_conveyor_end_right
		}
	} break
	
	case ConveyorVisualType.End_Left_Covered_Down: {
		// Change which end based on conveyor direction, since sprite gets flipped later
		if (direction == Direction.Right) {
			sprite_index = spr_conveyor_end_left_covered_down
		} else {
			sprite_index = spr_conveyor_end_right_covered_down
		}
	} break
	
	case ConveyorVisualType.End_Left_Covered_Out: {
		// Change which end based on conveyor direction, since sprite gets flipped later
		if (direction == Direction.Right) {
			sprite_index = spr_conveyor_end_left_covered_out
		} else {
			sprite_index = spr_conveyor_end_right_covered_out
		}
	} break
	
	case ConveyorVisualType.End_Right: {
		// Change which end based on conveyor direction, since sprite gets flipped later
		if (direction == Direction.Right) {
			sprite_index = spr_conveyor_end_right
		} else {
			sprite_index = spr_conveyor_end_left
		}
	} break
	
	case ConveyorVisualType.End_Right_Covered_Down: {
		// Change which end based on conveyor direction, since sprite gets flipped later
		if (direction == Direction.Right) {
			sprite_index = spr_conveyor_end_right_covered_down
		} else {
			sprite_index = spr_conveyor_end_left_covered_down
		}
	} break
	
	case ConveyorVisualType.End_Right_Covered_Out: {
		// Change which end based on conveyor direction, since sprite gets flipped later
		if (direction == Direction.Right) {
			sprite_index = spr_conveyor_end_right_covered_out
		} else {
			sprite_index = spr_conveyor_end_left_covered_out
		}
	} break
}


// Flip/rotate sprite for alternate direction conveyors
if (direction == Direction.Left) {
	sprite_index = sprite_duplicate(sprite_index)
	sprite_set_offset(sprite_index, 32, 0)
	image_xscale = -1
}

if (direction == Direction.Up) {
	sprite_index = sprite_duplicate(sprite_index)
	image_angle = 90
}

if (direction == Direction.Down) {
	sprite_index = sprite_duplicate(sprite_index)
	image_angle = -90
}

#endregion Set correct sprite

sprite_set_speed(sprite_index, 12, spritespeed_framespersecond)

function apply_interaction(obj) {
	with obj {
		if (other.direction == Direction.Right) {
			if (!pos.hit_right_conveyor) {
				pos.x_this_frame += global.conveyor_speed
				pos.hit_right_conveyor = true
			}
		} else {
			if (!pos.hit_left_conveyor) {
				pos.x_this_frame -= global.conveyor_speed
				pos.hit_left_conveyor = true
			}
		}
	}
}