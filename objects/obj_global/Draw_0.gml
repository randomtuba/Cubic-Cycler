var _no_back = (room == rm_mainmenu || room == rm_controls);

if (_no_back || !global.use_background) {
	draw_set_colour(_no_back ? c_black : make_colour_rgb(131, 175, 178));
	draw_rectangle(0, 0, room_width-1, room_height-1, false);
} else {
	if (view_current == 0) {
		draw_sprite_tiled_ext(
			spr_background, // Sprite
			0, // Frame
			0, // X
			0, // Y
			global.background_scale, // X Scale
			global.background_scale, // Y Scale
			c_white, // Color
			1 // Alpha
		)
	}
}

draw_set_color(c_white);

for (var i=0; i<4; i++) {
	view_visible[i+1] = (should_screenwrap())
}

if (keyboard_check_pressed(vk_f3)) { global.debug = !global.debug; }