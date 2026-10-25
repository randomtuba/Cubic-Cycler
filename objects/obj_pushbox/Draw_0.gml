var _do_multiple = !shredding;
for (var i=-1+!_do_multiple; i<2-!_do_multiple; i++) {
	for (var j=-1+!_do_multiple; j<2-!_do_multiple; j++) {
		var x_o = i*global.cam_size[0];
		var y_o = j*global.cam_size[1];
		draw_sprite_ext(sprite_index, image_index, x+x_o, y+y_o, image_xscale, image_yscale, image_angle, c_white, image_alpha*visible);
	}
}


if (instance_exists(obj_cubert) && global.debug) {
	draw_line(x, y, obj_cubert.x, obj_cubert.y);
}

//var _spot = [global.cam_size[0]/2, global.cam_size[1]/2]
//draw_set_color(c_blue);		draw_circle(_spot[0], _spot[1], 10, false);		draw_set_color(draw_getpixel(_spot[0], _spot[1]));
//draw_circle(mouse_x+32, mouse_y+32, 10, false);

//draw_set_color(c_red);		draw_circle(_spot[0], _spot[1], 10, false);		draw_set_color(draw_getpixel(_spot[0], _spot[1]));
//draw_circle(mouse_x-32, mouse_y+32, 10, false);

//draw_set_color(c_lime);		draw_circle(_spot[0], _spot[1], 10, false);		draw_set_color(draw_getpixel(_spot[0], _spot[1]));
//draw_circle(mouse_x, mouse_y+32, 10, false);