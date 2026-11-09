// main vars
pos = new Position(x, y, 0.90, 0.97, self, false)

rotation = 0;
collisions = []; update_collisions();
rider = noone;
touchspring = 0
shredding = false; shredded_pixels = 0;
wraps = true;
alarm[1] = 1

randomise();

function shred() {
	shredding = true; collisions = [];  // passthrough everything to leave bounds by force in hopes of disintegration
	
	var sprw = sprite_width/2;
	var sprh = sprite_height/2;
	var seg = 2;//particles will be spawned in distances of of seg*seg apart
	
	if (bbox_left < 0) {
		gravity_direction = 180;
		y = clamp(y, sprh+1, room_height-sprh-1);
		
		var to_shred = -bbox_left;
		for (var i=0; i<sprite_height; i+=seg) {
			for (var j=0; j<to_shred-shredded_pixels; j+=seg) {
				if (instance_number(obj_slicer_particle) > 200) { continue; }
				var p = instance_create_depth(2, y-sprh+i, depth-1, obj_slicer_particle);
				p.gravity_direction = gravity_direction+180+random_range(-10, 10);
				p.l = shredded_pixels+j;
				p.u = i;
			}
		}
		shredded_pixels = max(shredded_pixels, to_shred);
	}
	
	if (bbox_right > room_width) {
		gravity_direction = 0;
		y = clamp(y, sprh+1, room_height-sprh-1);
		
		var to_shred = bbox_right - room_width;
		for (var i=0; i<sprite_height; i+=seg) {
			for (var j=0; j<to_shred-shredded_pixels; j+=seg) {
				if (instance_number(obj_slicer_particle) > 200) { continue; }
				var p = instance_create_depth(room_width-2, y-sprh+i, depth-1, obj_slicer_particle);
				p.gravity_direction = gravity_direction+180+random_range(-10, 10);
				p.l = sprite_width-to_shred+j;
				p.u = i;
			}
		}
		shredded_pixels = max(shredded_pixels, to_shred);
	}
	
	if (bbox_top < 0) {
		gravity_direction = 90;
		x = clamp(x, sprw+1, room_width-sprw-1);
		
		var to_shred = -bbox_top;
		for (var i=0; i<sprite_width; i+= seg) {
			for (var j=0; j<to_shred-shredded_pixels; j+=seg) {
				if (instance_number(obj_slicer_particle) > 200) { continue; }
				var p = instance_create_depth(x-sprw+i, 2, depth-1, obj_slicer_particle);
				p.gravity_direction = gravity_direction+180+random_range(-10, 10);
				p.l = i;
				p.u = shredded_pixels+j;
			}
		}
		shredded_pixels = max(shredded_pixels, to_shred);
	}
	
	if (bbox_bottom > room_height) {
		gravity_direction = 270;
		x = clamp(x, sprw+1, room_width-sprw-1);
		
		var to_shred = bbox_bottom - room_height;
		for (var i=0; i<sprite_width; i+=seg) {
			for (var j=0; j<to_shred-shredded_pixels; j+=seg) {
				if (instance_number(obj_slicer_particle) > 200) { continue; }
				var p = instance_create_depth(x-sprw+i, room_height-2, depth-1, obj_slicer_particle);
				p.gravity_direction = gravity_direction+180+random_range(-10, 10);
				p.l = i;
				p.u = sprite_height-to_shred+j;
			}
		}
		shredded_pixels = max(shredded_pixels, to_shred);
	}
}

function update_collisions() {
	with (obj_global) { other.collisions = get_active_collisions(true) }
}

function apply_interaction(obj, dir) {
	with obj {
		if (global.camera_3d_for_act3 && (!am_i_in_view(x, y) || !am_i_in_view(other.x, other.y))) { return; }
		
		switch (dir) {
			case Direction.None: {
				// Nothing happens, this shouldn't really be reached
			} break
			case Direction.Down: { //cubert above box
				// Adjust speed
				var new_speed = (pos.y_speed + other.pos.y_speed) / 2 * 0.99
				// If the pushbox is grounded, just stop the object
				if (!checkGrounded(other, collisions).valid) {
					new_speed = 0
				}
				
				//test to fix smth
				var cubert_disco = false; //cubert disconnect off of cube onto a ledge or something
				if (!checkGrounded(self, collisions, 10, gravity_direction, other).valid) { cubert_disco = true; }
				//var _collisions_minus_pushbox = [];
				//for (var i=0; i<array_length(collisions); i++) { if (collisions[i] != obj_pushbox) { array_push(_collisions_minus_pushbox, collisions[i]); } }
				//if (!checkGrounded(self, _collisions_minus_pushbox).valid) {
				//	pos.y_speed = 0;
				//}
				
				pos.y_speed = new_speed * !cubert_disco
				other.pos.y_speed = new_speed
				
			
				// Snap obj
				if (!cubert_disco) {
					objSize = getObjSize(self)
					boxSize = getObjSize(other)
					pos.move(0, other.pos.point.getY() - boxSize.h / 2 - objSize.h / 2 + max(new_speed - 3, 0) - pos.point.getY());
				}
				//pos.setPos(
				//	pos.point.getX(),
				//	other.pos.point.getY() - boxSize.h / 2 - objSize.h / 2 + max(new_speed - 3, 0)
				//)
			} break
		
			case Direction.Up: { //box above cubert
				// Adjust speed
				var new_speed = (pos.y_speed + other.pos.y_speed) / 2
				pos.y_speed = new_speed
				other.pos.y_speed = new_speed
				
			
				// Snap box
				objSize = getObjSize(self)
				boxSize = getObjSize(other)
				other.pos.setPos(
					other.pos.point.getX(),
					pos.point.getY() - boxSize.h / 2 - objSize.h / 2
				)
			} break
		
			case Direction.Right: {
				// Adjust speed
				var speed_change = pos.x_speed / 20
				pos.x_speed -= speed_change
				other.pos.x_speed += speed_change
			
				// Snap obj
				objSize = getObjSize(self)
				boxSize = getObjSize(other)
				pos.setPos(
					other.pos.point.getX() - boxSize.w / 2 - objSize.w / 2,
					pos.point.getY()
				)
			} break
		
			case Direction.Left: {
				// Adjust speed
				var speed_change = pos.x_speed / 20
				pos.x_speed -= speed_change
				other.pos.x_speed += speed_change
				
				// Snap obj
				objSize = getObjSize(self)
				boxSize = getObjSize(other)
				pos.setPos(
					other.pos.point.getX() + boxSize.w / 2 + objSize.w / 2,
					pos.point.getY()
				)
			} break
		}
	}
}