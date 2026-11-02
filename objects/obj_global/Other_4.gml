if (layer_exists("Background")) { layer_destroy(layer_get_id("Background")); }



global.camera_follows_player_for_act2 = false;
var room_name = room_get_name(room);
if (string_starts_with(room_name, "rm2")) {
	global.camera_follows_player_for_act2 = true;
	update_camera(global.cam_size, true, instance_nearest(x, y, obj_cubert), 1);
	global.pedestal_active = false;
	
} else { update_camera(global.cam_size); }

if (string_starts_with(room_name, "rm3")) {
	global.camera_3d_for_act3 = true;
	window_set_fullscreen(false);
	
} else if (global.camera_3d_for_act3) {
	global.camera_3d_for_act3 = false;
	window_set_fullscreen(false);
	window_set_size(global.cam_size[0], global.cam_size[1]);
}



//global.level_x = clamp(global.level_x, 0, array_length(global.generators_destroyed_map[0])-1);
//global.level_y = clamp(global.level_y, 0, array_length(global.generators_destroyed_map)-1);
