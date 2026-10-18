pressed = false
// Set to correct visuals
image_index = broadcast_id

function update_connected() {
	// Update connected switch blocks
	with (obj_switch_block) {
		if (receiving_id = other.broadcast_id) {
			audio_play_sound(sfx_button_press, 0, false)
			toggle()
		}
	}
}

function apply_interaction(obj) {
	if (obj.object_index == obj_pushbox) {
		if (!pressed) {
			pressed = true

			// Set to pressed image
			image_index = broadcast_id + 3
	
			update_connected()
	
			with (obj_global) send_collision_updates()
		}
	}
}