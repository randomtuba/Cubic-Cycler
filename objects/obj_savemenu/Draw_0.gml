var _press = ((keyboard_check(ord("V"))) && room != rm_mainmenu && room != rm_controls);
enabled = (enabled && (enable_k < 0.95 || _press)) || (_press && !enabled && enable_k < 0.35);
visible = enabled;