if (!pressed) {
	pressed = true

	// Set to pressed image
	image_index = broadcast_id + 3
	
	update_connected()
	
	update_other_collisions()
}