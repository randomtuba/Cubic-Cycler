function apply_interaction(obj) {
	with obj {
		if (obj.object_index == obj_cubert && !lose_state) {
			lose_state = true
			lose_timer = 0.25*sec
		}
	}
}