break_timer = sec
is_breaking = false

function apply_interaction(obj, dir) {
	if (obj.object_index == obj_cubert) {
		is_breaking = true
		with (obj_cubert) {
			if ((keyboard_check(vk_down) || keyboard_check(ord("S"))) && checkGrounded(self, collisions).valid && !immobile) {
				break_timer = 0
			}
		}
	}
}