if (place_meeting(x, y, obj_cubert) && !array_contains(global.tesseracts[1], false) && image_index < 15) {
	image_index++
} else if (image_index == 15) {
	instance_destroy(obj_cubert)
	instance_destroy(obj_world_map)
	room_goto(rm_winscreen)
}