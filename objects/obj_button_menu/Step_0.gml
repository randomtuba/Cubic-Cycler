// mouse pointer over button makes it light up
if (position_meeting(mouse_x, mouse_y, self)) {
	image_index = x > 690 ? 3 : 1
} else {
	image_index = x > 690 ? 2 : 0
}

if (gamepad_button_check_pressed(0, gp_face1)) { run_button_menu(0) }
if (gamepad_button_check_pressed(0, gp_face3) || gamepad_button_check_pressed(0, gp_face2) || gamepad_button_check_pressed(0, gp_face4)) { run_button_menu(room_width) }