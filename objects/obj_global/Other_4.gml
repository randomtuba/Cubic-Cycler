var c=0;

layer_destroy(layer_get_id("Background"));

view_visible[0] = true;
view_enabled = true;
camera_set_view_size(view_camera[0], room_width, room_height);
view_wport[0] = room_width;
view_hport[0] = room_height;
for (var i=-1; i<2; i++) {
	for (var j=-1; j<2; j++) {
		if ((i!=0 && j!=0) || (i==0 && j==0)) { continue; }
		c++;
		view_visible[c] = true;
		camera_set_view_pos(view_camera[c], i*room_width, j*room_height);
		camera_set_view_size(view_camera[c], room_width, room_height);
		view_wport[c] = room_width;
		view_hport[c] = room_height;
		view_xport[c] = 0;
		view_yport[c] = 0;
	}
}