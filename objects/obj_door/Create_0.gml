fix_sprite()

function fix_sprite() {
	if is_open {
		// Hidden
		image_index = 3
	} else {
		// Matching colored sprite
		image_index = receiving_id
	}
}

function toggle() {
	is_open = !is_open
	
	fix_sprite()
}