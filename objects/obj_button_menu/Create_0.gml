image_speed = 0

function run_button_menu(_x = x) {
	if (_x > 690) {
		room_goto(rm_controls)
	} else {
		room_goto(rm_tut_top_left)
	}
}