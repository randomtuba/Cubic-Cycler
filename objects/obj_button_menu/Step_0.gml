// mouse pointer over button makes it light up
if (position_meeting(mouse_x, mouse_y, self)) {
	image_index = x > 690 ? 3 : 1
} else {
	image_index = x > 690 ? 2 : 0
}