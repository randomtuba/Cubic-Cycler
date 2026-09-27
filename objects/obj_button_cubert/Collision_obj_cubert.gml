if (!pressed) {
	pressed = true

	// Set to pressed image
	image_index = broadcast_id + 3
	
	update_connected()
	
	with (obj_global) send_collision_updates()
}