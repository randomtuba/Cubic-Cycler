pressed = false
// Set to correct visuals
image_index = broadcast_id

function update_connected() {
	// Update connected doors
	with (obj_door) {
		if (receiving_id == other.broadcast_id) {
			toggle()
		}
	}
	
	// Update connected switch blocks
	with (obj_switch_block) {
		if (receiving_id = other.broadcast_id) {
			toggle()
		}
	}
}