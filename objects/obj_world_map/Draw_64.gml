var _press = (keyboard_check(vk_tab) && room != rm_mainmenu && room != rm_controls);
enabled = (enabled && (enable_k < 0.95 || _press)) || (_press && !enabled && enable_k < 0.35); //kind of withhold your command until it finishes moving
enable_k = lerp(enable_k, enabled, 0.2);

if (enable_k > 0) {
	//draw_set_alpha(0.7)
	//show_debug_message("DRAW EVENT: " + room_get_name(room));
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _map = get_level_map();
	
	var gap = 100*room_width/room_height;
	var ratio = room_height/room_width;
	var w = 6;
	var _cx = room_width/2;
	var _cy = room_height/2;
	var _oi = array_length(_map[0])/2;
	var _oj = array_length(_map)/2;
	
	var _init_y = lerp(room_height+gap, _cy-_oj*gap*ratio, (enable_k<enabled)? enable_k : 2-enable_k);
	var _init_x = _cx-_oi*gap;
	var _y = _init_y ;
	for(var i = 0; i<array_length(_map[0]); i++){
		var _x = _init_x;
		for(var j = 0; j<array_length(_map); j++){
			
			draw_set_color(global.generators_destroyed_map[j][i] ? c_lime : c_red)
			draw_rectangle(_x,_y, _x + gap,_y +gap*ratio,false);
			
			var _speci_room = get_level_map()[i][j];
			var _spr = get_room_thumb(_speci_room);
			if (_spr != -1) {
				draw_sprite_stretched(_spr, 0, _x, _y, gap, gap*ratio);
				draw_rectangle_thick_outline(_x,_y, _x + gap, _y+gap*ratio, w/2);
			}
			
			var _is_current_level = (global.level_x == j && global.level_y == i);
			if(_is_current_level){
				draw_set_color(c_blue);
				draw_rectangle_thick_outline(_x,_y, _x + gap, _y+gap*ratio, w);
			}
			
			
			var _is_hovering = (_mx > _x && _mx < _x+gap && _my > _y && _my < _y+gap*ratio);
			if(_is_hovering){
				draw_set_color(c_black);
				draw_rectangle_thick_outline(_x,_y, _x + gap, _y +gap*ratio, w);
			
				var _is_clicked_with_permission = mouse_check_button_pressed(mb_left) && (global.debug || global.generators_destroyed_map[j][i]);
				if(_is_clicked_with_permission){
					global.level_y = i;
					global.level_x = j;
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
		_y += gap*ratio;
	}
	
	draw_set_color(c_dkgray);
	draw_rectangle_thick_outline(_init_x, _init_y, _init_x+2*((room_width/2)-_init_x), _y, w, true);
	draw_set_color(c_white)
	draw_set_alpha(1)
	
}