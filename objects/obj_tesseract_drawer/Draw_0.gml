timer++;

if (collect_timer < sec * 5) {

	if (collected && instance_exists(obj_cubert)) {
		//TODO: make the rotation and scale change after collection or something
		x = lerp(xstart, obj_cubert.x, collect_k);
		y = lerp(ystart, obj_cubert.y, collect_k);
		rot_xw_spd *= 1.0022 //exponential spin faster when collected
		rot_yz_spd *= 1.00232 
		var collectioncurve = power(collect_k,2)
		scale = lerp(400, 800, collectioncurve)
		curhue = (curhue+(0.0025*collect_timer))%255
		tesscolor = make_colour_hsv(curhue,255,lerp(0,255,collectioncurve))
	}

	if (instance_exists(obj_cubert) && point_distance(x, y, obj_cubert.x, obj_cubert.y) < 100) { collected = true; }
	collect_k = lerp(collect_k, collected, 0.003);
	
	rot_xw += rot_xw_spd;
	rot_yz += rot_yz_spd;

	make_dubrot_mat();
	draw_tessa(); // draws the tessa. not that hard
}