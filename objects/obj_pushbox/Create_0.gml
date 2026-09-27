// main vars
x_speed = 0
y_speed = 0
rotation = 0;
collisions = []; update_collisions();
rider = noone;
touchspring = 0

function update_collisions() {
	with (obj_global) {
		other.collisions = get_active_collisions(true)
	}
}