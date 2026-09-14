///@description create non_main_cuberts if im main
if (is_main_cubert) {
	for (var i=-1; i<2; i++) {
		for (var j=-1; j<2; j++) {
			if (i == j) { continue; }
			var non_main_cubert = instance_create_depth(x, y, depth, obj_cubert);
			non_main_cubert.main_cubert = self;
			non_main_cubert.is_main_cubert = false;
			non_main_cubert.main_cubert_offset = [i*room_width, j*room_height];
			array_push(non_main_cuberts, non_main_cubert);
		}
	}
}