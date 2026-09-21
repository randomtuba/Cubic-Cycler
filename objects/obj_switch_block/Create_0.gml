fix_sprite()

function fix_sprite() {
	if is_on {
		// Enabled sprite
		image_index = receiving_id
	} else {
		// Disabled sprite
		image_index = receiving_id + 3
	}
}

function toggle() {
	is_on = !is_on
	
	fix_sprite()
}