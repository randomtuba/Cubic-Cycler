for (var i=-1; i<2; i++) {
	for (var j=-1; j<2; j++) {
		var x_o = i*global.cam_size[0];
		var y_o = j*global.cam_size[1];
		draw_sprite_ext(sprite_index, image_index, x+x_o, y+y_o, image_xscale, image_yscale, image_angle, c_white, image_alpha*visible);
	}
}