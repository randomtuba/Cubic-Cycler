draw_set_font(MainFont)

switch (room) {
	case rm_tut_top_left:
		draw_text(50, 100, "Welcome to Cubic Cycler!\nUse WASD or arrow keys\nto move.")
		if (!should_screenwrap()) draw_text(650, 100, "When you break a generator,\nyou can travel to other rooms.")
	break
	case rm_tut_top_right:
		draw_text(325, 100, "Press TAB to open the map!")
		if (!should_screenwrap()) draw_text(625, 30, "If you get to one end of the map,\nyou can wrap to the other end! Try it!")
	break
	case rm_tut_bottom_left:
		draw_text(350, 100, "Press R to restart to\nyour last checkpoint.")
		if (!should_screenwrap()) draw_text(350, 200, "Now try going back to the start!")
	break
}