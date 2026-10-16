timer++;

if (collect_timer < sec * 5) {

	if (collected && instance_exists(obj_cubert)) {
		//TODO: make the rotation and scale change after collection or something
		x = lerp(xstart, obj_cubert.x, collect_k);
		y = lerp(ystart, obj_cubert.y, collect_k);
	}

	if (instance_exists(obj_cubert) && point_distance(x, y, obj_cubert.x, obj_cubert.y) < 100) { collected = true; }
	collect_k = lerp(collect_k, collected, 0.01);
	
	rot_xw += rot_xw_spd;
	rot_yz += rot_yz_spd;

	make_dubrot_mat();
	draw_tessa(); // ???
}