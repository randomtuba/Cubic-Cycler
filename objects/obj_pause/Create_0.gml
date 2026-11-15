progress_k = 0;
progress = 0;

value = 0.8;
value_setter = function(){
	global.music_vol = value;
	with (obj_music_handler) { audio_sound_gain(song, global.music_vol, 100); }
} //to be modified in instance creation (or not)
pause_menu_func = function(){return;} //to be modified in instance creation (or not)


//functions in question
function pause_menu_slider_func() {
	if (abs(1-progress_k) > 0.025) { return; }

	value = clamp(value, 0, 1);
	var _hover = mouse_x > bbox_left+8 && mouse_x < (bbox_right-8) && mouse_y > bbox_top && mouse_y < bbox_bottom
	if (mouse_check_button(mb_left) && _hover) {
		var p = (mouse_x - (bbox_left+8)) / (bbox_right-bbox_left-16)
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