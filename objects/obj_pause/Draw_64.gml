draw_set_font(MildlyImportantFont)


progress_k = lerp(progress_k, progress, 0.10);
if (progress_k >= 2-0.02) { progress = 0; progress_k = 0; }

if (keyboard_check_pressed(vk_enter)) {
	if (progress == 1) { progress = 2; }
	else { progress_k = 0; progress = 1; }
}

image_angle = 90*(1-progress_k);
image_alpha = 1-abs(1-progress_k);
//x = lerp(0, xstart, clamp(progress_k, 0, 1));
//y = lerp(ystart, room_height, clamp(progress_k, 1, 2)-1);

if (instance_exists(global.pause_menu) && global.pause_menu.id != id) { 
	var pmenu = global.pause_menu;
	var dist = point_distance(pmenu.xstart, pmenu.ystart, xstart, ystart);
	var ang = point_direction(pmenu.xstart, pmenu.ystart, xstart, ystart);
	x = pmenu.xstart+dist*dcos(ang+image_angle)
	y = pmenu.ystart-dist*dsin(ang+image_angle)
}


draw_self();
pause_menu_func();

//draw_text(15, 10, "Controls:")
//draw_text(15, 60, "A / left arrow / dpad left (gp) - Move Left")
//draw_text(15, 120, "D / right arrow / dpad right (gp) - Move Right")
//draw_text(15, 180, "W / up arrow / space / dpad up (gp)/ A (gp) - Jump")
//draw_text(15, 240, "S / down arrow / dpad down (gp) - Dive")
//draw_text(15, 300, "R / start (gp) - Restart")
//draw_text(15, 360, "Tab / select (gp) - Show Map")
//draw_text(15, 420, "E / X (gp) - Interact")
//draw_text(15, 480, "M / Y (gp) - Toggle Minimap")


draw_set_font(MainFont)