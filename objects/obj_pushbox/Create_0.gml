// main vars
x_speed = 0
y_speed = 0
rotation = 0;
collisions = []; update_collisions();
rider = noone;
touchspring = 0

function update_collisions() {
	collisions = [layer_tilemap_get_id("Tiles_1"), obj_block_fragile, obj_pushbox];
	with obj_switch_block {
		if is_on {
			array_push(other.collisions, self)
		}
	}
	with obj_door {
		if !is_open {
			array_push(other.collisions, self)
		}
	}
}