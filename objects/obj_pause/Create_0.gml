progress_k = 0;
progress = 0;

innerText = "";
innerSpr = -1; //overrides menu spr

value = 0.8;
value_setter = function(){
	global.music_vol = value;
	with (obj_music_handler) { audio_sound_gain(song, global.music_vol, 100); }
} //to be modified in instance creation (or not)
pause_menu_func = function(_hover){return;} //to be modified in instance creation (or not)


//functions in question
function pause_menu_go_to_menu(_hover){
	if (mouse_check_button_pressed(mb_left) && _hover) {
		with (obj_cubert) { instance_destroy(); }
		//room_goto(rm_mainmenu);
	}
}
function pause_menu_teleport_act(_hover) {
	if (mouse_check_button_pressed(mb_left) && _hover) {
		if (room == rm_mainmenu || room == rm_controls) {
			with (obj_music_handler) { audio_stop_sound(song) }
			room_goto(rm_tut_top_left);
		} else {
			global.act = value;
			actPlus();
		}
	}
}
function pause_menu_savefile(_hover) {
	var _exists = file_exists(game_save_id + "checkpoint" + string(value) + ".json");
	if (global.savefile == value) {
		innerText = _exists ? "LOAD" : "EMPTY";
	} else {
		innerText = _exists ? "SAVE " + string(value) : "NEW " + string(value);
	}
	
	if (mouse_check_button_pressed(mb_left) && _hover) {
		if (global.savefile != value) { global.savefile = value; }
		else {
			checkpoint_read_file();
			with(obj_cubert) { apply_current_checkpoint(); }
			checkpoint_restore_progress()
		}
	}
}
function pause_menu_slider_func(_hover) {
	if (abs(1-progress_k) > 0.025) { return; }

	value = clamp(value, 0, 1);
	if (mouse_check_button(mb_left) && _hover) {
		var p = (mouse_x - camera_get_view_x(view_camera[7]) - (bbox_left+8)) / (bbox_right-bbox_left-16)
		value = lerp(value, p, 0.5);
		value_setter();
	}
	
	draw_set_color(_hover ? (mouse_check_button(mb_left) ? c_blue : c_aqua) : c_lime);
	draw_set_alpha(image_alpha);
	
	var _w = (bbox_right-8)-(bbox_left+8);
	draw_rectangle(bbox_left+8, bbox_top+8, bbox_left+8 + _w*value, bbox_bottom-8, false);
	draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
	
	draw_set_color(c_white);
	draw_set_alpha(1);
	
}