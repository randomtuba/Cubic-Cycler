update_collisions();

if (collision_rectangle(x-31, y-31, x+31, y+31, collisions, true, true) != noone) {
	//bounce back if there's collision in the way
	room_goto(current_room_data[0]);
	x = current_room_data[1];
	y = current_room_data[2];
	x_speed = -5*current_room_data[3];
	y_speed = -5*current_room_data[4];
	global.level_x = current_room_data[5];
	global.level_y = current_room_data[6];
	
	//alt: drill through
	//for (var i=-32; i<33; i++) {
	//	for (var j=-32; j<33; j++) {
	//		tilemap_set(layer_tilemap_get_id("Tiles_1"), 0, floor(32*(x+i)/room_width), floor(20*(y+j)/room_height));
	//	}
	//}
}