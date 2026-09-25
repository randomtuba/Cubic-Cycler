// main vars
x_speed = 0
y_speed = 0
rotation = 0;
x_scale = 0.5;
//collision_map = layer_tilemap_get_id("Tiles_1")
collisions = []; update_collisions();

// lose state
lose_state = false
lose_timer = 0

// quality of life vars
coyote_time = 0
jump_buffer = 0
springyspring = 0

// Conveyors and Tractor Beams
touching_right_conveyor = false
touching_left_conveyor = false
touching_up_tractor = false
touching_down_tractor = false
touching_right_tractor = false
touching_left_tractor = false


// cool effects
jump_k = 0;
jump_j_max = sec;
bounciness = 1;

// create visual warp cuberts
main_cubert = self;
is_main_cubert = true;
main_cubert_off_i = [0, 0];
non_main_cuberts = [];
alarm[0] = 1;
current_room_data = []; update_current_room_data(room, x, y, x_speed, y_speed, global.level_x, global.level_y);

function update_current_room_data(_room, _x, _y, _x_speed, _y_speed, _level_x, _level_y) {
	current_room_data = [_room, _x, _y, _x_speed, _y_speed, _level_x, _level_y];
	return current_room_data;
}

function restart() {
	if (global.checkpoint_id == -1) {
		room_goto(rm_start)
		global.level_x = 2
		global.level_y = 1
		x = 64
		y = 480
	} else {
		room_goto(global.checkpoint_room)
		global.level_x = global.checkpoint_level_x
		global.level_y = global.checkpoint_level_y
		x = global.checkpoint_x
		y = global.checkpoint_y
	}
}

function update_collisions() {
	collisions = [layer_tilemap_get_id("Tiles_1"), obj_block_fragile, obj_pushbox, obj_conveyor];
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

function room_index_bounded(_i = global.level_x, _j = global.default_y) {
	return (_j >= 0) && (_j < array_length(global.level_map)) &&
		(_i >= 0) && (_i < array_length(global.level_map[0])) &&
		global.level_map[_j][_i] != -1
}


function faux_place_meeting(_xoff, _yoff, _collisions) {
	var _touch = false;
	for (var i=0; i<array_length(non_main_cuberts); i++) {
		var q = non_main_cuberts[i];
		if (place_meeting(q.x+_xoff, q.y+_yoff, _collisions)) { _touch = true; break; }
		var _i = q.main_cubert_off_i[0];
		var _j = q.main_cubert_off_i[1];
		if (global.generators_destroyed_map[global.level_x][global.level_y] == true && !room_index_bounded(global.level_x-_i, global.level_y-_j)) {
			var _x = q.x+_xoff - abs(sprite_width/2)*_i;
			var _y = q.y+_yoff - abs(sprite_height/2)*_j;
			//draw_circle(_x, _y, 5, false); //was for debugging 
			if (2 <= _x && _x <= room_width-2 && 2 <= _y && _y <= room_height-2) { _touch = true; }
		}
	}
	//if room invalid left && my right faux cubert
	return _touch;
}


function move_and_collide_with_faux(x_speed, y_speed, _collisions, _iter = 32, reset_speeds_if_cant = true, apply_bounce = true) {
	//check any of the 9 cuberts can move
	var _can_both = !place_meeting(x+x_speed, y+y_speed, _collisions) && !faux_place_meeting(x_speed, y_speed, _collisions)
	var _can_ud = !place_meeting(x, y+y_speed, _collisions) && !faux_place_meeting(0, y_speed, _collisions)
	var _can_lr = !place_meeting(x+x_speed, y, _collisions) && !faux_place_meeting(x_speed, 0, _collisions)
	
	if (y_speed > 0 && apply_bounce && !_can_ud && self.jump_k <= 0) { self.jump_k = self.jump_j_max+abs(y_speed); self.bounciness = abs(y_speed); }
	
	//todo: make the 9 able to increment break timer
	if (array_contains(_collisions, obj_block_fragile)) {
		var _fragile_list = ds_list_create();
		var _fragile_count = collision_rectangle_list(x+x_speed-sprite_width/2, y+y_speed-sprite_height/2, x+x_speed+sprite_width/2, y+y_speed+sprite_height/2, obj_block_fragile, false, true, _fragile_list, false);
		for (var i=0; i<_fragile_count; i++) { _fragile_list[|i].break_timer-=1; }
		
		for (var i=0; i<array_length(non_main_cuberts); i++) {
			var q = non_main_cuberts[i];
			var _faux_fragile_list = ds_list_create();
			var _faux_fragile_count = collision_rectangle_list(q.x+x_speed-sprite_width/2, q.y+y_speed-sprite_height/2, q.x+x_speed+sprite_width/2, q.y+y_speed+sprite_height/2, obj_block_fragile, false, true, _faux_fragile_list, false);
			for (var j=0; j<_faux_fragile_count; j++) { if (instance_exists(_faux_fragile_list[|j])) { _faux_fragile_list[|j].break_timer-=1; } }
			ds_list_destroy(_faux_fragile_list);
			
		}
		
		
		ds_list_destroy(_fragile_list);
	}
	
	//push box conditions
	if (array_contains(_collisions, obj_pushbox)) {
		var _pushbox_list = ds_list_create();
		var _pushbox_count = collision_rectangle_list(x+x_speed-sprite_width/2, y+y_speed-sprite_height/2, x+x_speed+sprite_width/2, y+y_speed+sprite_height/2, obj_pushbox, false, true, _pushbox_list, false);
		
		for (var i=0; i<_pushbox_count; i++) {
			var _box = _pushbox_list[|i];
			if (abs(y - _box.y) < 33) { _box.x_speed = x_speed / 2 }
			if (abs(x - _box.x) < 30 && y < _box.y) { _box.rider = self; _box.alarm[0] = 2; }
		}
		
		ds_list_destroy(_pushbox_list);
		
		for (var i=0; i<array_length(non_main_cuberts); i++) {
			var q = non_main_cuberts[i];
			var _faux_pushbox_list = ds_list_create();
			var _faux_pushbox_count = collision_rectangle_list(q.x+x_speed-sprite_width/2, q.y+y_speed-sprite_height/2, q.x+x_speed+sprite_width/2, q.y+y_speed+sprite_height/2, obj_pushbox, false, true, _pushbox_list, false);
			
			for (var j=0; j<_faux_pushbox_count; j++) {
				var _box = _faux_pushbox_list[|j];
				if (abs(q.y - _box.y) < 24) { _box.x_speed = x_speed / 2 }
				if (abs(q.x - _box.x) < 30 && q.y < _box.y) { _box.rider = self; _box.alarm[0] = 2; }
			}
			
			ds_list_destroy(_faux_pushbox_list);
			
		}
	}
	
	// Conveyors
	if (array_contains(_collisions, obj_conveyor)) {
		// Create list of touching conveyors
		var _conveyor_list = ds_list_create();
		var _conveyor_count = collision_rectangle_list(x+x_speed-sprite_width/2, y+y_speed-sprite_height/2, x+x_speed+sprite_width/2, y+y_speed+sprite_height/2, obj_conveyor, false, true, _conveyor_list, false);
		
		// Check through touching conveyors
		for (var i=0; i<_conveyor_count; i++) {
			var _conveyor = _conveyor_list[|i];
			if (abs((y + 32) - _conveyor.y) < 10) { 
				// Set tracker variables to avoid being pushed faster 
				// when touching multiple parts of long conveyors
				if (_conveyor.points_right) {
					touching_right_conveyor = true
				} else {
					touching_left_conveyor = true
				}
			}
		}
		// Destroy list as it's no longer in use
		ds_list_destroy(_conveyor_list);
		
		// Repeat above with non-main cuberts
		for (var i=0; i<array_length(non_main_cuberts); i++) {
			var q = non_main_cuberts[i];
			// Create list of touching conveyors
			var _faux_conveyor_list = ds_list_create();
			var _faux_conveyor_count = collision_rectangle_list(q.x+x_speed-sprite_width/2, q.y+y_speed-sprite_height/2, q.x+x_speed+sprite_width/2, q.y+y_speed+sprite_height/2, obj_conveyor, false, true, _faux_conveyor_list, false);
			
			// Check through touching conveyors
			for (var j=0; j<_faux_conveyor_count; j++) {
				var _conveyor = _faux_conveyor_list[|j];
				if (abs((q.y + 32) - _conveyor.y) < 10) { 
					// Set tracker variables to avoid being pushed faster 
					// when touching multiple parts of long conveyors
					if (_conveyor.points_right) {
						touching_right_conveyor = true
					} else {
						touching_left_conveyor = true
					}
				}
			}
			// Destroy list as it's no longer in use
			ds_list_destroy(_faux_conveyor_list);
			
		}
	}
	
	//slowly decrease percent of x_speed and y_speed until it's possible to fit
	while (_iter > 0 && (!_can_ud  || !_can_lr || (_can_lr && _can_ud && !_can_both))) {
		if (!_can_lr) { x_speed *= (_iter-1)/_iter; }
		if (!_can_ud || (_can_lr && _can_ud && !_can_both)) { y_speed *= (_iter-1)/_iter; }
		_can_both = !place_meeting(x+x_speed, y+y_speed, _collisions) && !faux_place_meeting(x_speed, y_speed, _collisions)
		_can_ud = !place_meeting(x, y+y_speed, _collisions) && !faux_place_meeting(0, y_speed, _collisions)
		_can_lr = !place_meeting(x+x_speed, y, _collisions) && !faux_place_meeting(x_speed, 0, _collisions)
		_iter--;
	}
	x += _can_lr * x_speed;
	y += _can_ud * y_speed;
	
	//clear velocity when hitting something
	if (reset_speeds_if_cant) {
		if (!_can_lr) { self.x_speed = 0 }
		if (!_can_ud) { self.y_speed = 0 }
	}
}