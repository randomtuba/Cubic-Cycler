if (global.minimap) {
	view_visible[6] = true;
	draw_set_color(c_black);
	draw_set_alpha(0.2);
	var _l = camera_get_view_x(view_camera[0]);
	var _u = camera_get_view_y(view_camera[0]);
	draw_rectangle(_l+global.cam_size[0]*3/4, _u+global.cam_size[1]*3/4, _l+global.cam_size[0], _u+global.cam_size[1], false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	camera_set_view_pos(view_camera[6], 0, 0)
	camera_set_view_size(view_camera[6], room_width, room_height)
	view_xport[6] = global.cam_size[0]*3/4;
	view_wport[6] = global.cam_size[0]/4;

	view_yport[6] = global.cam_size[1]*3/4;
	view_hport[6] = global.cam_size[1]/4;
}