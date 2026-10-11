var _press = ((keyboard_check(vk_v)) && room != rm_mainmenu && room != rm_controls);
enabled = (enabled && (enable_k < 0.95 || _press)) || (_press && !enabled && enable_k < 0.35);
if (enabled) {
	object_set_visible(this, true);
}