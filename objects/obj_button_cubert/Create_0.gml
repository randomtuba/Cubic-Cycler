pressed = false
// Set to correct visuals
image_index = broadcast_id

function update_connected(playsound=true) {
	// Update connected switch blocks
	with (obj_switch_block) {
		if (receiving_id = other.broadcast_id) {
			if (playsound) audio_play_sound(sfx_button_press, 0, false)
			toggle()
		}
	}
}

function apply_interaction(obj) {
	if (obj.object_index == obj_cubert) {
		if (!pressed) {
			pressed = true
			
			// Add to buttons pressed list (Act 2)
			if (!array_contains(global.buttons_pressed, id) && stays_pressed && global.act == 2) {
				array_push(global.buttons_pressed, id)
			}

			// Set to pressed image
			image_index = broadcast_id + 3
	
			update_connected()
	
			with (obj_global) send_collision_updates()
		}
	}
}
