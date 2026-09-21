if (other.is_vertical) {
	if (other.is_up_or_right) {
		touching_up_tractor = true
	} else {
		touching_down_tractor = true
	}
} else {
	if (other.is_up_or_right) {
		touching_right_tractor = true
	} else {
		touching_left_tractor = true
	}
}