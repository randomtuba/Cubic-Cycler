// Mirror sprite if left conveyor
if (!points_right) {
	sprite_index = sprite_duplicate(sprite_index)
	sprite_set_offset(sprite_index, 32, 0)
	image_xscale = -1
	
}


sprite_set_speed(sprite_index, 6, spritespeed_framespersecond)

function apply_interaction(obj) {
	with obj {
		if (other.points_right) {
			x_this_frame += global.conveyor_speed
			hit_right_conveyor = true
		} else {
			x_this_frame -= global.conveyor_speed
			hit_left_conveyor = true
		}
	}
}