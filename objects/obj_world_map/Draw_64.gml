if(keyboard_check(vk_tab)){
	//draw_set_alpha(0.7)
	//show_debug_message("DRAW EVENT: " + room_get_name(room));
	var _y = 100;
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	
	for(var i = 0; i<4; i++){
		var _x = 300;
		for(var j = 0; j<4; j++){
			draw_set_color(global.generators_destroyed_map[j][i] ? c_lime : c_red)
		
			draw_rectangle(_x,_y, _x + 100,_y +100,false);
		
			if(global.level_x == j && global.level_y == i){
				draw_set_color(c_blue);
				draw_rectangle(_x,_y, _x + 100,_y +100,false);
				var w = 10;
				draw_set_color(global.generators_destroyed_map[j][i] ? c_lime : c_red)
				draw_rectangle(_x+w,_y+w, _x + 100-w,_y +100-w,false);
			}
			if(_mx > _x && _mx < _x+100 && _my > _y && _my < _y+100){
				draw_set_color(c_black);
				//show_debug_message("Is hovering");
				draw_rectangle(_x,_y, _x + 100,_y +100,false);
				var w = 10;
				draw_set_color(global.generators_destroyed_map[j][i] ? c_lime : c_red)
				draw_rectangle(_x+w,_y+w, _x + 100-w,_y +100-w,false);
			
				if(mouse_check_button_pressed(mb_left) && (global.debug || global.generators_destroyed_map[j][i])){
					global.level_x = j;
					global.level_y = i;
					room_goto(global.level_map[global.level_y][global.level_x]);
					var room_name = global.level_map[global.level_y][global.level_x];
					var level_spawn = get_spawn_coords_by_room(room);
					with (obj_cubert) {
						x = level_spawn[0];
						y = level_spawn[1];
				
					
					}
				}
			}
			_x = _x + 100;
		}
		_y = _y + 100;
	}
	draw_set_color(c_white)
	draw_set_alpha(1)
	
}