if (global.debug) {
	draw_text(16, 16, "debug="+(global.debug?"true":"false"))
	draw_text(16, 16, "\nact:room="+string(global.act)+":"+room_get_name(room))
	draw_text(16, 16, "\n\nlevel_x="+string(global.level_x))
	draw_text(16, 16, "\n\n\nlevel_y="+string(global.level_y))
	draw_text(16, 16, "\n\n\n\ncubert count="+string(instance_number(obj_cubert)))
	if (instance_exists(obj_cubert)) {
		var _cub = instance_nearest(x, y, obj_cubert);
		//var _cub_grouned = checkGrounded(_cub, _cub.collisions, 5, _cub.gravity_direction);
		var _cub_grouned = _cub.coyote_time > 0
		draw_text(16, 16, "\n\n\n\n\ncubert grounded = "+(_cub_grouned?"true":"false"));
		var _Dir = angle_direction_to_enum_Direction(_cub.gravity_direction);
		var _Dir_Arr = ["Up", "Down", "Left", "Right"];
		draw_text(16, 16, "\n\n\n\n\n\ncubert grav Dir = "+_Dir_Arr[_Dir]);
	}
}