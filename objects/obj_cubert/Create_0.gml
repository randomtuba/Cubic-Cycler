//main vars
x_speed = 0
y_speed = 0
collision_map = layer_tilemap_get_id("Tiles_1")
lose_state = false
lose_timer = 0

//cool effects
jump_k = 0;


//create visual warp cuberts
main_cubert = self;
is_main_cubert = true;
main_cubert_offset = [0, 0];
non_main_cuberts = [];
alarm[0] = 1;

function faux_place_meeting(_xoff, _yoff, _collision_map) {
	var _touch = false;
	for (var i=0; i<array_length(non_main_cuberts); i++) {
		var q = non_main_cuberts[i];
		if (place_meeting(q.x+_xoff, q.y+_yoff, collision_map)) { _touch = true; break; }
	}
	return _touch;
}

function move_and_collide_with_faux(x_speed, y_speed, collision_map, _iter = 32, reset_speeds_if_cant = true) {
	var _can_both = !place_meeting(x+x_speed, y+y_speed, collision_map) && !faux_place_meeting(x_speed, y_speed, collision_map)
	var _can_ud = !place_meeting(x, y+y_speed, collision_map) && !faux_place_meeting(0, y_speed, collision_map)
	var _can_lr = !place_meeting(x+x_speed, y, collision_map) && !faux_place_meeting(x_speed, 0, collision_map)
	while (_iter > 0 && (!_can_ud  || !_can_lr || (_can_lr && _can_ud && !_can_both))) {
		if (!_can_lr) { x_speed *= (_iter-1)/_iter; }
		if (!_can_ud || (_can_lr && _can_ud && !_can_both)) { y_speed *= (_iter-1)/_iter; }
		_can_both = !place_meeting(x+x_speed, y+y_speed, collision_map) && !faux_place_meeting(x_speed, y_speed, collision_map)
		_can_ud = !place_meeting(x, y+y_speed, collision_map) && !faux_place_meeting(0, y_speed, collision_map)
		_can_lr = !place_meeting(x+x_speed, y, collision_map) && !faux_place_meeting(x_speed, 0, collision_map)
		_iter--;
	}
	x += _can_lr * x_speed;
	y += _can_ud * y_speed;
	if (reset_speeds_if_cant) {
		if (!_can_lr) { self.x_speed = 0 }
		if (!_can_ud) { self.y_speed = 0 }
	}
}