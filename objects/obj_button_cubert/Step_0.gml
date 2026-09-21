if (!pressed) {
	// Set to normal image
	image_index = broadcast_id
	
	// Update connected doors
	with (obj_door) {
		if (receiving_id == other.broadcast_id) {
			image_index = receiving_id
		}
	}
	
} else {
	// Set to pressed image
	image_index = broadcast_id + 3
	
	// Update connected doors
	with (obj_door) {
		if (receiving_id == other.broadcast_id) {
			image_index = 3
		}
	}
}

// Update pushbox collision map for changed doors
with (obj_pushbox) {
	update_collisions()
}

// Reset pressed state for buttons that don't stay pressed
if (!stays_pressed) {
	pressed = false
}