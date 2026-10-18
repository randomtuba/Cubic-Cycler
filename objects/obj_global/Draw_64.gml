if (global.debug) {
	draw_text(16, 16, "debug="+(global.debug?"true":"false"))
	draw_text(16, 16, "\nact="+string(global.act))
	draw_text(16, 16, "\n\nlevel_x="+string(global.level_x))
	draw_text(16, 16, "\n\n\nlevel_y="+string(global.level_y))
	draw_text(16, 16, "\n\n\n\ncubert count="+string(instance_number(obj_cubert)))
}