// Reset pressed state for buttons that don't stay pressed
if (pressed && !stays_pressed && !place_meeting(x, y, obj_cubert)) {
	pressed = false
	
	// Set to normal image
	image_index = broadcast_id
	
	update_connected()
	
	with (obj_global) send_collision_updates()
}

// Keep buttons pressed on death
if (array_contains(global.buttons_pressed, id) && !pressed) {
	pressed = true

	// Set to pressed image
	image_index = broadcast_id + 3
	
	update_connected(false)
	
	with (obj_global) send_collision_updates()	
}