var _do_multiple = should_screenwrap() && !(global.camera_3d_progress > 0);
for (var i=-1+!_do_multiple; i<2-!_do_multiple; i++) {
	for (var j=-1+!_do_multiple; j<2-!_do_multiple; j++) {
		var y_o_3d = (global.camera_3d_progress > 0)*sprite_get_height(spr_block_top_only)*obj_global.camera_3d_depth_ratio*global.camera_3d_progress;
		var x_o = i*global.cam_size[0];
		var y_o = j*global.cam_size[1] - y_o_3d;
		draw_sprite_ext(sprite_index, image_index, x+x_o, y+y_o, image_xscale, image_yscale, image_angle, c_white, image_alpha*visible);
	}
}