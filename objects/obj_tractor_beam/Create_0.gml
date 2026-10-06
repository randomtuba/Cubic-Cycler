if (!is_up_or_right) {
	image_angle = 180
}

if (!is_vertical) {
	image_angle -= 90
}

function apply_interaction(obj) {
	with (obj) {
		switch (other.facing_direction) {
			case Direction.Up:
				if (!pos.hit_tractors[Direction.Up]) {
					pos.hit_tractors[Direction.Up] = true
					pos.y_speed -= global.tractor_strength
				}
			break
			
			case Direction.Down:
				if (!pos.hit_tractors[Direction.Down]) {
					pos.hit_tractors[Direction.Down] = true
					pos.y_speed += global.tractor_strength
				}
			break
			
			case Direction.Left:
				if (!pos.hit_tractors[Direction.Left]) {
					pos.hit_tractors[Direction.Left] = true
					pos.x_speed -= global.tractor_strength
				}
			break
			
			case Direction.Right:
				if (!pos.hit_tractors[Direction.Right]) {
					pos.hit_tractors[Direction.Right] = true
					pos.x_speed += global.tractor_strength
				}
			break
		}
	}
}