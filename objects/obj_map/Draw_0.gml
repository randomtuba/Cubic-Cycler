if(keyboard_check(vk_tab)){
	//draw_set_alpha(0.7)
	var _y = 100;
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
		if(mouse_x > _x && mouse_x < _x+100 && mouse_y > _y && mouse_y < _y+100){
			draw_set_color(c_black);
			draw_rectangle(_x,_y, _x + 100,_y +100,false);
			var w = 10;
			draw_set_color(global.generators_destroyed_map[j][i] ? c_lime : c_red)
			draw_rectangle(_x+w,_y+w, _x + 100-w,_y +100-w,false);
		}
		_x = _x + 100;
		}
		_y = _y + 100;
	}
	draw_set_color(c_white)
	draw_set_alpha(1)
	
}