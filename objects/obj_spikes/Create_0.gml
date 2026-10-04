function apply_interaction(obj) {
	with obj {
		if (!lose_state) {
			lose_state = true
			lose_timer = 0.25*sec
		}
	}
}