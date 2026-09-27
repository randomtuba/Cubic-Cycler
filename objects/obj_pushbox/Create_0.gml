// main vars
x_speed = 0
y_speed = 0
x_this_frame = 0
y_this_frame = 0
rotation = 0;
collisions = []; update_collisions();
rider = noone;
touchspring = 0
touching_up_tractor = false
touching_down_tractor = false
touching_right_tractor = false
touching_left_tractor = false

function update_collisions() {
	with (obj_global) {
		other.collisions = get_active_collisions()
	}
}
// my attempt at moving plats functionality (commented out bc it doesn't work)

//function move_and_collide_with_faux(x_speed, y_speed, _collisions, _iter = 32, reset_speeds_if_cant = true, apply_bounce = true) {
//	var _touching_platforms = get_contacting(_collisions, obj_moving_platform)
//	for (var i = 0; i < array_length(_touching_platforms[0]); i++) {
//		var _platform = array_get(_touching_platforms[0], i)
//		var _direction = array_get(_touching_platforms[1], i)
//		
//		x_speed += _platform.get_x_speed()
//		y_speed += _platform.get_y_speed()
	
//		if (_platform.get_x_speed() > 0 && x_speed < _platform.get_x_speed() && _direction == Direction.Left) {
//			x_speed = _platform.get_x_speed()
//		}
//		if (_platform.get_x_speed() < 0 && x_speed > _platform.get_x_speed() && _direction == Direction.Right) {
//			x_speed = _platform.get_x_speed()
//		}
//		if (_platform.get_y_speed() > 0 && y_speed < _platform.get_y_speed() && _direction == Direction.Up) {
//			y_speed = _platform.get_y_speed()
//		}
//		if (_platform.get_y_speed() < 0 && y_speed > _platform.get_y_speed() && _direction == Direction.Down) {
//			y_speed = _platform.get_y_speed()
//		}
//	}
//}