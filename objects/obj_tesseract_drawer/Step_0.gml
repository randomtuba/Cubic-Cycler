if (collected) collect_timer++

if (collect_timer < sec * 5) {
	if (!collected && instance_exists(obj_cubert) && point_distance(x, y, obj_cubert.x, obj_cubert.y) < 100 && room != rm2_airlock) {
		collected = true;
		audio_play_sound(sfx_tesseract_collect, 0, false, global.sfx_vol)
	}

	repeat (speed_mult) {
		if (collected && instance_exists(obj_cubert)) {
			x = lerp(xstart, obj_cubert.x, collect_k);
			y = lerp(ystart, obj_cubert.y, collect_k);
			rot_xw_spd *= 1.0022 //exponential spin faster when collected
			rot_yz_spd *= 1.00232
			var collectioncurve = power(collect_k, 2)
			if (back_to_zero) {
				scale = lerp(shrink_start_scale, 0, shrink_k)
			} else {
				scale = lerp(400, 800, collectioncurve)
			}
			curhue = (curhue + (0.0025 * collect_timer)) % 255
			tesscolor = make_colour_hsv(curhue, 255, lerp(0, 255, collectioncurve))
		}

		if (instance_exists(obj_cubert) && point_distance(x, y, obj_cubert.x, obj_cubert.y) < 100 && room != rm2_airlock) { collected = true; }
		collect_k = lerp(collect_k, collected, 0.003);
		if (!back_to_zero && collect_k >= 0.925) {
			back_to_zero = true
			shrink_start_scale = scale   // start shrinking from the current size (fixes jump)
		}
		if (back_to_zero) { shrink_k = min(shrink_k + 0.002, 1) }

		rot_xw += rot_xw_spd;
		rot_yz += rot_yz_spd;
	}

	make_dubrot_mat();
} else if (!array_contains(global.tesseracts[0], id)) {
	array_push(global.tesseracts[0], id)
}

if (array_contains(global.tesseracts[0], id)) instance_destroy()