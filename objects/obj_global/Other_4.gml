if (layer_exists("Background")) { layer_destroy(layer_get_id("Background")); }

update_camera([1024, 640]);


global.camera_follows_player_for_act2 = false;

var room_name = room_get_name(room);
if (string_starts_with(room_name, "rm2")) {
	global.camera_follows_player_for_act2 = true;
}

if (global.camera_follows_player_for_act2) {
	
}

