if (!should_screenwrap() || shredding) {
	shredding = true; collisions = [];  // passthrough everything to leave bounds by force in hopes of disintegration
	
	randomise();
	
	var sprw = sprite_width/2;
	var sprh = sprite_height/2;
	var seg = 2;//particles will be spawned in distances of of seg*seg apart
	
	if (bbox_left < 0) {
		gravity_direction = 180;
		y = clamp(y, sprh+1, room_height-sprh-1);
		
		var to_shred = -bbox_left;
		for (var i=0; i<sprite_height; i+=seg) {
			for (var j=0; j<to_shred-shredded_pixels; j+=seg) {
				var p = instance_create_depth(2, y-sprh+i, depth-1, obj_slicer_particle);
				p.gravity_direction = gravity_direction+180+random_range(-10, 10);
				p.l = shredded_pixels+j;
				p.u = i;
			}
		}
		shredded_pixels = to_shred;
	}
	
	if (bbox_right > room_width) {
		gravity_direction = 0;
		y = clamp(y, sprh+1, room_height-sprh-1);
		
		var to_shred = bbox_right - room_width;
		for (var i=0; i<sprite_height; i+=seg) {
			for (var j=0; j<to_shred-shredded_pixels; j+=seg) {
				var p = instance_create_depth(room_width-2, y-sprh+i, depth-1, obj_slicer_particle);
				p.gravity_direction = gravity_direction+180+random_range(-10, 10);
				p.l = sprite_width-to_shred+j;
				p.u = i;
			}
		}
		shredded_pixels = to_shred;
	}
	
	if (bbox_top < 0) {
		gravity_direction = 90;
		x = clamp(x, sprw+1, room_width-sprw-1);
		
		var to_shred = -bbox_top;
		for (var i=0; i<sprite_width; i+= seg) {
			for (var j=0; j<to_shred-shredded_pixels; j+=seg) {
				var p = instance_create_depth(x-sprw+i, 2, depth-1, obj_slicer_particle);
				p.gravity_direction = gravity_direction+180+random_range(-10, 10);
				p.l = i;
				p.u = shredded_pixels+j;
			}
		}
		shredded_pixels = to_shred;
	}
	
	if (bbox_bottom > room_height) {
		gravity_direction = 270;
		x = clamp(x, sprw+1, room_width-sprw-1);
		
		var to_shred = bbox_bottom - room_height;
		for (var i=0; i<sprite_width; i+=seg) {
			for (var j=0; j<to_shred-shredded_pixels; j+=seg) {
				var p = instance_create_depth(x-sprw+i, room_height-2, depth-1, obj_slicer_particle);
				p.gravity_direction = gravity_direction+180+random_range(-10, 10);
				p.l = i;
				p.u = sprite_height-to_shred+j;
			}
		}
		shredded_pixels = to_shred;
	
	}
}