// Reset pressed state for buttons that don't stay pressed
if (pressed && !stays_pressed && !place_meeting(x, y, obj_pushbox)) {
	pressed = false
	
	// Set to normal image
	image_index = broadcast_id
	
	update_connected()
	
	update_other_collisions()
}