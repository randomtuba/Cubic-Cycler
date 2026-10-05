// main vars
pos = new Position(x, y, 0.90, 0.97, self)

rotation = 0;
collisions = []; update_collisions();
rider = noone;
touchspring = 0

function update_collisions() {
	with (obj_global) {
		other.collisions = get_active_collisions(true)
	}
}