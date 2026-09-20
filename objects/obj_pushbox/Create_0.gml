// main vars
x_speed = 0
y_speed = 0
rotation = 0;
collisions = []; update_collisions();
rider = noone;

function update_collisions() {
	collisions = [layer_tilemap_get_id("Tiles_1"), obj_block_fragile, obj_cubert];
}