image_index = broadcast_id + 3
with (obj_door) {
	if (receiving_id == other.broadcast_id) {
		image_index = 3
	}
}