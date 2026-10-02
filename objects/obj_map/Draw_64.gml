if(keyboard_check(vk_tab)){
	//draw_set_alpha(0.7)
	show_debug_message("DRAW EVENT: " + room_get_name(room));
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
			show_debug_message("Is hovering");
			draw_rectangle(_x,_y, _x + 100,_y +100,false);
			var w = 10;
			draw_set_color(global.generators_destroyed_map[j][i] ? c_lime : c_red)
			draw_rectangle(_x+w,_y+w, _x + 100-w,_y +100-w,false);
			
			if(mouse_check_button_pressed(mb_left) /*&& global.generators_destroyed_map[j][i] uncomment for non dev gameplay*/){
				global.level_x = j;
				global.level_y = i;
				room_goto(global.level_map[global.level_y][global.level_x]);
				var room_name = global.level_map[global.level_y][global.level_x];
				with (obj_cubert) {
					var level_spawn_x;
					var level_spawn_y;
					
					switch(room_name){
						case rm_start:
							level_spawn_x = 160;
							level_spawn_y = 480;
							break;
						case rm_spring_intro:
							level_spawn_x = 128;
							level_spawn_y = 480;
							break;
						case rm_pushbox_intro:
							level_spawn_x = 928;
							level_spawn_y = 480;
							break;
						case rm_spring_boost:
							level_spawn_x = 736;
							level_spawn_y = 352;
							break;
						case rm_spikes:
							level_spawn_x = 256;
							level_spawn_y = 416;
							break;
						case rm_pushbox_fall:
							level_spawn_x = 512;
							level_spawn_y = 64;
							break;
						case rm_spring_box:
							level_spawn_x = 128;
							level_spawn_y = 480;
							break;
						case rm_climb:
							level_spawn_x = 640;
							level_spawn_y = 384;
							break;
						case rm_spring_hard:
							level_spawn_x = 128;
							level_spawn_y = 480;
							break;
						case rm_fall:
							level_spawn_x = 480;
							level_spawn_y = 64;
							break;
						case rm_fragile_blocks:
							level_spawn_x = 448;
							level_spawn_y = 0;
							break;
						case rm_doubledown:
							level_spawn_x = 448;
							level_spawn_y = 32;
							break;
						case rm_many_buttons:
							level_spawn_x = 864;
							level_spawn_y = 320;
							break;
						case rm_awkward:
							level_spawn_x = 576;
							level_spawn_y = 0;
							break;
						case rm_pushbox_and_fragile:
							level_spawn_x = 960;
							level_spawn_y = 288;
							break;
						default:
							level_spawn_x = 160;
							level_spawn_y = 480;
							break;
						}
						x = level_spawn_x;
						y = level_spawn_y;
				
					
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