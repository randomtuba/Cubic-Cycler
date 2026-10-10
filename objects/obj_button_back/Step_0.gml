// mouse pointer over button makes it light up
if (position_meeting(mouse_x, mouse_y, self)) {
	image_index = 1
} else {
	image_index = 0
}

if (gamepad_button_check_pressed(0, gp_face1)) { room_goto(rm_mainmenu); }