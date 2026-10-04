if(keyboard_check(vk_tab) && room != rm_mainmenu && room != rm_controls){
	//draw_set_alpha(0.7)
	//show_debug_message("DRAW EVENT: " + room_get_name(room));
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _map = get_level_map();
	
	var gap = 100;
	var _cx = room_width/2;
	var _cy = room_height/2;
	var _oi = array_length(_map[0])/2;
	var _oj = array_length(_map)/2;
	
	var _y = _cy-_oj*gap;
	for(var i = 0; i<array_length(_map[0]); i++){
		var _x = _cx-_oi*gap;
		for(var j = 0; j<array_length(_map); j++){
			draw_set_color(global.generators_destroyed_map[j][i] ? c_lime : c_red)
		
			draw_rectangle(_x,_y, _x + gap,_y +gap,false);
		
			if(global.level_x == j && global.level_y == i){
				draw_set_color(c_blue);
				draw_rectangle(_x,_y, _x + gap,_y +gap,false);
				var w = 10;
				draw_set_color(global.generators_destroyed_map[j][i] ? c_lime : c_red)
				draw_rectangle(_x+w,_y+w, _x + gap-w,_y +gap-w,false);
			}
			if(_mx > _x && _mx < _x+gap && _my > _y && _my < _y+gap){
				draw_set_color(c_black);
				//show_debug_message("Is hovering");
				draw_rectangle(_x,_y, _x + gap,_y +gap,false);
				var w = 10;
				draw_set_color(global.generators_destroyed_map[j][i] ? c_lime : c_red)
				draw_rectangle(_x+w,_y+w, _x + gap-w,_y +gap-w,false);
			
				if(mouse_check_button_pressed(mb_left) && (global.debug || global.generators_destroyed_map[j][i])){
					global.level_x = j;
					global.level_y = i;
					room_goto(get_level_map()[global.level_y][global.level_x]);
					var level_spawn = get_spawn_coords_by_room(room);
					with (obj_cubert) {
						x = level_spawn[0];
						y = level_spawn[1];
					}
				}
			}
			_x += gap;
		}
		_y += gap;
	}
	draw_set_color(c_white)
	draw_set_alpha(1)
	
}