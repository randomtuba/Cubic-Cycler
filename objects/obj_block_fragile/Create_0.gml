break_timer = sec
is_breaking = false

function apply_interaction(obj, dir) {
	if (obj.object_index == obj_cubert) {
		is_breaking = true
		with (obj_cubert) {
			var _down = (keyboard_check(vk_down) || keyboard_check(ord("S")) || gamepad_button_check(0, gp_padd));
			if (_down) {
				other.break_timer = 0
			}
		}
	}
}