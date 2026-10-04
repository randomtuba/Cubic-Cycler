draw_set_font(MainFont)

switch (room) {
	case rm_tut_top_left:
		draw_text(50, 100, "Welcome to Cubic Cycler!\nUse WASD or arrow keys\nto move.")
		if (!instance_exists(obj_generator)) draw_text(650, 100, "When you break a generator,\nyou can travel to other rooms.")
	break
	case rm_tut_bottom_left:
		draw_text(350, 100, "Press R to restart to\nyour last checkpoint.")
	break
}