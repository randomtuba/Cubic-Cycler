if (layer_exists("Background")) { layer_destroy(layer_get_id("Background")); }
update_camera([1024, 640]);

global.camera_follows_player_for_act2 = false;
var room_name = room_get_name(room);
if (string_starts_with(room_name, "rm2")) { global.camera_follows_player_for_act2 = true; }



//global.level_x = clamp(global.level_x, 0, array_length(global.generators_destroyed_map[0])-1);
//global.level_y = clamp(global.level_y, 0, array_length(global.generators_destroyed_map)-1);
