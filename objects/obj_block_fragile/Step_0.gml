if (break_timer > sec * 0.75) {
	image_index = 0
} else if (break_timer > sec * 0.5) {
	image_index = 1
} else if (break_timer > sec * 0.25) {
	image_index = 2
} else if (break_timer > 0) {
	image_index = 3
} else {
	//should they respawn without restarting the room?
	//if (alarm[0] <= 0) { alarm[0] = 3*sec; }
	instance_destroy()
}