draw_set_font(MainFont)

switch (room) {
	case rm_tut_top_left:
		if (global.gamepad) {
			draw_text(50, 100, "Welcome to Cubic Cycler!\nUse DPad or Left Joystick\nto move.")
		} else {
			draw_text(50, 100, "Welcome to Cubic Cycler!\nUse WASD or arrow keys\nto move.")
		}
		if (!should_screenwrap()) draw_text(650, 100, "When you break a generator,\nyou can travel to other rooms.")
	break
	case rm_tut_top_right:
		if (global.gamepad) {
			draw_text(325, 100, "Press SELECT to open the map!")
		} else {
			draw_text(325, 100, "Press TAB to open the map!")
		}
		if (!should_screenwrap()) draw_text(625, 30, "If you get to one end of the map,\nyou can wrap to the other end! Try it!")
	break
	case rm_tut_bottom_left:
		if (global.gamepad) {
			draw_text(350, 100, "Press START to restart to\nyour last checkpoint.")
		} else {
			draw_text(350, 100, "Press R to restart to\nyour last checkpoint.")
		}
		if (!should_screenwrap()) draw_text(350, 200, "Now try going back to the start!")
	break
}

if (keyboard_check(vk_anykey)) { global.gamepad = false; }
var gp_buttons = [gp_face1, gp_padu, gp_padl, gp_padd, gp_padr, gp_start, gp_select];
for (var i=0; i<array_length(gp_buttons); i++) { if (gamepad_button_check(0, gp_buttons[i])) { global.gamepad = true; break;} }